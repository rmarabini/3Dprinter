// dimensions
y = 21;
yp =  49;
z = 3.0;

//radii pins
r = 1.5; //1.7 printed
R = 4;

//cube([x,y,z]);
$fn=200;

y_off = 4;
baseh = 4;
bh =6;
br = 5;
ph = 6;

// pins
pin1 = [13.3, y, z];
pin2 = [14.3, yp, z];
pin3 = [119.3, yp, z];
pin4 = [125, y, z];
extraX = 140;
pin33 = [extraX, yp, z];
pin44 = [extraX, y, z]; 
pin33p = [extraX, yp, -3*z+2];
pin44p = [extraX, y, -3*z+2]; 

module structure(){

/*
translate(pin1) pintack(h=ph, r=r, bh=bh, br=br);
translate(pin2) pintack(h=ph, r=r, bh=bh, br=br);
translate(pin3) pintack(h=ph, r=r, bh=bh, br=br);
translate(pin4) pintack(h=ph, r=r, bh=bh, br=br);
*/

// join pins
hull(){
// pin1-2
translate(pin1)  cylinder(h=baseh, r=br);
translate(pin2) cylinder(r=br,h=baseh);    
}


hull(){
// pin2-3
translate(pin2) cylinder(r=br,h=baseh);        
translate(pin33)  cylinder(h=baseh, r=br);
}

//hull(){
// pin3-4
//translate(pin3)  cylinder(h=baseh, r=br);
//translate(pin4) cylinder(r=br,h=baseh);        
//}


hull(){
// pin4-1
translate(pin44) cylinder(r=br,h=baseh);        
translate(pin1)  cylinder(h=baseh, r=br);
}

//hanger
hull(){
translate(pin33) cylinder(r=1.5*br,h=baseh);        
translate(pin44) cylinder(r=1.5*br,h=baseh);        
translate(pin33p) cylinder(r=1.5*br,h=baseh);        
translate(pin44p) cylinder(r=1.5*br,h=baseh);        
}
}

difference(){
    structure();
    translate([-8,-50, -2]+(pin33p + pin44)/2) cube([8,100,7]);
    translate(pin1 +[0, 0, -1]) cylinder(h=bh+10, r=1);
    translate(pin2 +[0, 0, -1]) cylinder(h=bh+10, r=1);
    translate(pin3 +[0, 0, -1]) cylinder(h=bh+10, r=1);
    translate(pin4 +[0, 0, -1]) cylinder(h=bh+10, r=1);

    }

module pin(h=10, r=4, lh=3, lt=1, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally

  if (side) {
    pin_horizontal(h, r, lh, lt);
  } else {
    pin_vertical(h, r, lh, lt);
  }
}

module pintack(h=10, r=4, lh=3, lt=1, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt);
  }
}


// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r, lh, lt);
    
    // center cut
    translate([-r*0.5/2, -(r*2+lt*2)/2, h/4]) cube([r*0.5, r*2+lt*2, h]);
    translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    // translate([0, 0, h/4]) rotate([90, 0, 0]) cylinder(h=r*2, r=r*0.5/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -lt-r*1.125, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt+r*1.125, -1]) cube([r*4, lt*2, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  translate([0, h/2, r*1.125-lt]) rotate([90, 0, 0]) pin_vertical(h, r, lh, lt);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}
