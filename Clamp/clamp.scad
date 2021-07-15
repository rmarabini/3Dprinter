$fn=50;
//Radius of tube to clamp to
R=4.5;
//Width of ring
w=3;
//Bolt screw radius
screwR=1.55;
//Bolt/nut wrench size
nutR=3.5;
//Bolt/nut trap size
nutH=2;
//Space of clamp
space=7.5;
//
hfactor = 2.5;


module clamp(R,w,screwR,nutR,nutH,space){
    h=screwR*hfactor*2;
    difference(){
        union(){
            cylinder(r=R+w,h = h);
            translate([0,-(R+w),0]) cube([(R+w+h),(R+w)*2,h]);
        }
        cylinder(r=R,h=h);
        translate([0,-space/2,0]) cube([(R+w+h),space,h]);
        
        
        translate([(R+w+screwR*hfactor),(R+w),screwR*hfactor]) rotate([90,0,0]) cylinder(r=screwR,h=(R+w)*2);
        translate([(R+w+screwR*
        hfactor),(R+w),screwR*hfactor]) rotate([90,0,0]) cylinder(r=nutR,h=nutH, $fn=6);
        
    }

}


clamp(R,w,screwR,nutR,nutH,space);