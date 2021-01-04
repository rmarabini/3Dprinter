 
 doArc=true;
 doBase=false;
 separator=false;
 
 
 lc_h=5; // large cylinder heigh 
 lc_r=50; // large cylinder radius
 n = 16; // number holes
 sc_h=lc_h+2; // small cylinder heigh 
 sc_r=2; // small cylinder radius
 sc_R= lc_r - 3 * sc_r; // place small holes on this circle
 
 arc_r = 35; // arch radius
 arc_w = 20; // arch width
 arc_h = arc_r; //
 arc_l = lc_h;
 
 arc_length=10;
 arc_width=3;
 arc_height=3;
 
 $fn=200;
 step = 360/n;
 offset = step/2.; // rotate holes by this ammount
 
function vectorLength(v1,v2) = sqrt(
    (v2[0]-v1[0])*(v2[0]-v1[0])+
    (v2[1]-v1[1])*(v2[1]-v1[1])+
    (v2[2]-v1[2])*(v2[2]-v1[2]));

function lookAt(v1, v2) =
    let(v = v2-v1)
    [
       0,
       acos(v[2]/vectorLength(v1,v2)),
       atan2(v[1], v[0])
    ];

module cylinderBetween(p1,p2,radius)
{
    translate(p1)
    rotate(lookAt(p1,p2))
    cylinder(vectorLength(p1,p2),radius,radius);
}

module ancor(length, width, height)
{
    translate([-length/2,
               arc_r-width/2,
               lc_h-height])
    cube([length, width, height+1]);
    translate([-length/2,
               -arc_r-width/2,
                lc_h-height])
    cube([length, width, height+1]);
}

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 100) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

module fullarc(length, width, height)
{
    translate([-length/2,
               arc_r-width/2,
               lc_h])
 cube([arc_w, arc_l, arc_h]);
    translate([-length/2,
               -arc_r-width/2,
                lc_h])
 cube([arc_w, arc_l, arc_h]);
  rotate([90,0,90])
  translate([0,height+arc_l, -length/2])
  linear_extrude(arc_w)  
  arc(arc_r-arc_l/2, [0, 180], arc_l);   
//ancor
        translate([-arc_length/2,
               arc_r-arc_width/2,
               lc_h-arc_height])
    cube([arc_length, arc_width, arc_height+1]);
    translate([-arc_length/2,
               -arc_r-arc_width/2,
                lc_h-arc_height])
    cube([arc_length, arc_width, arc_height+1]);

}
    

//Base
if(doBase)
{
difference(){
 cylinder(h=lc_h,r=lc_r);

// place passing cylinder
 for ( angle = [0 : step : 359.99] ){
     translate([sin(angle+offset)*sc_R, 
                cos(angle+offset)*sc_R, -1 ])
     cylinder(h = sc_h, r=sc_r);
     }
     
 // join pairs of cylinders
 for ( angle = [0 : 2*step : 359.99] ){
     x1 = sin(angle+offset)*sc_R;
     y1 = cos(angle+offset)*sc_R;
     x2 = sin(angle+offset+step)*sc_R;
     y2 = cos(angle+offset+step)*sc_R;
     P1=[x1, y1, 0];
     P2=[x2, y2, 0];
     cylinderBetween(P1, P2, sc_r);
     }
     ancor(arc_length+1, arc_width+1, arc_height);
  }
 }
 //arch
if(doArc){ 
 difference() {
     fullarc(arc_w, arc_l, arc_h);
     cylinder(80,sc_r,sc_r);
 }
}