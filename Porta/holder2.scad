$fn = 200;
x = 9;
y = 9;

z = 4.6;
difference(){
   cube(size = [x,y,z], center = true);
   
    union(){
   cylinder(h=z, r=1., center=true);
   translate([0,0,.4]) 
   cylinder(h=z, r=1.75, center=true);
   translate([1.256,0,1.4]) 
   cylinder(h=z, r=3.90, center=true);
        
   translate([4.5,0,0]) 
   cube(size=[10, 1.2, 6], center= true);
    }
}

