$fn=60;
tolerance = .1;

diameter_pawn = 18.2 - tolerance;
diameter_bishop = 25.5 - tolerance;
diameter_magnet = 6.3 - tolerance;
h=2.5;

linear_extrude(height = h){
difference(){
    circle(d=diameter_pawn);
    circle(d=diameter_magnet);    
//    circle(d=diameter_bishop);
//    circle(d=diameter_magnet);    
}

//translate([diameter_bishop,0,0])
//difference(){
//}

} //strude