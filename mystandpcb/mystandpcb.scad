$fn = 50; 
 
height = 11.5;
 
module support(){ 
 rotate(-90, [0, 1, 0])
  difference() {  
     difference() {
       translate([-height/2.,-height/2.,0])
         cube( [height/2, height, height + 5] ); 
       translate([-height,-height,height]){
          cube([height*2.,height,1.57+0.1]);}
     }
       translate([-height,1,-1 ]){
          cube([height*2.,5,5]);}
     
  }
}

for (i=[-1:1]) {
  for (j=[-2:1]) {

    translate([i * height *2, j * height * 2 -  height/2,0]) support();
}}