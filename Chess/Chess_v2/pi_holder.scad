$fn = 100;
support_pp = [ 40, 40];
support_pm = [ 40,-40];
support_mp = [-40, 40];
support_mm = [-40,-40];
support_r = 4;
support_h = 50;
support_ir = 1.45;

module oneHul(trans1, trans2, r){
    hull(){
    translate(trans1)
        cylinder(r=r, h= 3);
    translate(trans2)
        cylinder(r=r, h= 3);
    }
}

module allHull(pp, pm, mp, mm, r){
oneHul(pp, pm, r);
oneHul(pm, mm, r);
oneHul(mm, mp, r);
oneHul(mp, pp, r);
translate(pp)
    difference() {
    cylinder(r=6.2/2., h= 9);
    cylinder(r=support_ir, h= 9);
    }
}


module rasPi(){
 mx = -29; px = - mx;
 my = -24.5; py = - my;
 pp = [mx, my]; pm=[mx,-40]; mp = [-40, my]; mm=[-40,-40];
 allHull(pp, pm, mp, mm, 6.2/2.-1);
 pp2 = [-mx, -my]; pm2=[-mx,40]; mp2 = [40, -my]; mm2=[40,40];
 allHull(pp2, pm2, mp2, mm2, 6.2/2.-1.);
 pp3 = [mx, -my]; pm3=[mx,40]; mp3 = [-40, -my]; mm3=[-40,40];
 allHull(pp3, pm3, mp3, mm3, 6.2/2.-1);
 pp4 = [-mx, my]; pm4=[-mx,-40]; mp4 = [40, my]; mm4=[40,-40];
 allHull(pp4, pm4, mp4, mm4, 6.2/2.-1);
}

module support(){
allHull(support_pp, support_pm, support_mp, support_mm, support_r-2.);
translate(support_pp)
       difference(){
       cylinder(r=support_r, h= support_h);
       cylinder(r=support_ir, h= support_h);
       }
translate(support_pm)
       difference(){
       cylinder(r=support_r, h= support_h);
       cylinder(r=support_ir, h= support_h);
       }
translate(support_mp)
       difference(){
       cylinder(r=support_r, h= support_h);
       cylinder(r=support_ir, h= support_h);
       }
translate(support_mm)
       difference(){
       cylinder(r=support_r, h= support_h);
       cylinder(r=support_ir, h= support_h);
       }
    }
    
// pi holder    
rasPi();
support();

//IC holder   
/*    
width=50;
length=100-16;
heigth=1.2 +.2;
  
difference(){
    union(){
    translate([width/2.,0,10]){
    cube([support_r * 2, length, 20], true);    
    }
    translate([-width/2.,0,10]){
    cube([support_r * 2, length, 20], true);    
    }} // union end
translate([0,0,19]){
cube([width+2, length, 3], true);    
}

}
*/