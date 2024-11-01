$fn=200;
// main cylinder
D=6;
H=1.2 + 1.8;
// cylinder extracted from main culinder
d=4.0; //4.4;
h=1.2;

// 
twezeersY=3.94;
twezeersX=2;

//
holderZ=  4;

intersection(){
 cylinder(d=D,h=H+holderZ); // main cylinder
 translate([-d/2-1,-2.6,3])
   cube([d+2,.70,holderZ]); // remove back.
}
difference(){
   cylinder(d1=D-0.4,d2=D,h=H); // main cylinder
    translate([0,.3,h])
   cylinder(d=d,h=1.8); // extract this cylinder
    translate([-d/2.,0.2,h])
   cube([d,d,d]); // front extraction
    translate([-twezeersX/2.,+D/2-twezeersY+1,0])
   cube([twezeersX,twezeersY,d]); // channel for tweezers
    translate([-d/2,-3.48,0])
   cube([d,d/5,d]); // remove back.
cylinder(d=2, h=10);
}

