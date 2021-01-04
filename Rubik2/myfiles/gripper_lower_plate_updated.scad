$fn=30;
difference()
{
   import("/home/roberto/ssd/3Dprinter/Rubik2/files/gripper_lower_plate_update.stl", convexity = 5);
  
   translate([5.5,22, -17])
   cube(size =[4, 2, 54] , center = true);
}
/*
   translate([1,27.25,7.45])
   rotate([90,0,90])
   cylinder(r1=1.5, r2=1.5, h=10, center = true);

   translate([1,16.75,7.45])
   rotate([90,0,90])
   cylinder(r1=1.5, r2=1.5, h=10, center = true);
*/