
difference(){
    import("Laser_PCB_Box.stl");
    union(){
           {
           translate([35,0.075,4])    
           cube([10, 52.9, 50]);
           translate([15,0.075,15])    
           cube([20, 52.9, 50]);         
           }
     } 
 }