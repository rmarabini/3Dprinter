// dimensions
y = 16;
yp =  62;
z = 3.0;

//r
r = 1.; // hole screw
R = 4;

//cube([x,y,z]);
$fn=200;

y_off = 4;
baseh = 4;
bh =6;
br = 5;
ph = 6;

// pins
pin1 = [16, y, z];
pin2 = [16, yp, z];


extraX = 28;
pin33 = [extraX, yp, z];
pin44 = [extraX, y, z]; 
pin33p = [extraX, yp, -3*z+2];
pin44p = [extraX, y, -3*z+2]; 

module structure(){


// join pins
hull(){
// pin1-2
translate(pin1) cylinder(h=baseh, r=br);
translate(pin2) cylinder(h=baseh, r=br);    
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
    translate([-8,-50, -2]+(pin33p + pin44)/2) cube([8,100,7]); // remove extra hanger
    translate(pin1 +[0, 0, -1]) cylinder(h=bh+10, r=r); // hole screw
    translate(pin2 +[0, 0, -1]) cylinder(h=bh+10, r=r); // hole screw
    translate(pin1 +[10, 0, -11]) cylinder(h=bh+15, r=r); // hole screw
    translate(pin2 +[10, 0, -11]) cylinder(h=bh+15, r=r); // hole screw
}

