$fn = 50;
$fs=0.1;
$fa=3;

diameter2= 5;
diameter = 4.25;
height = 16;
height2 = 30;

pin_diameter = 0.90;
awg30 = 0.255;
awg=0.5;

difference(){
//handle for manual tool
cylinder(height, diameter2, diameter2);
// hex bit handle for electric screwdriver
/*   linear_extrude(height=height)
			regular_polygone(6,3.55);
    
//hole for back screw
//   cylinder(16, 2.5/2, 2.5/2);        
    import("M25_screw.stl");
*/
}
translate([0, 0, height]) {
    difference() {
        //main cylinder
        cylinder(height2, diameter/2, diameter/2);
        // make cylinder hollow
        cylinder(height2, 0.8, 0.8);
        // place for twisted wire
        translate([0, 0, height2-1]) cylinder(1, (diameter-1.6)/2, (diameter-1.6)/2);
        // first wire hole
        translate([0, 0, height2]) rotate([45, 0, 0]) translate([0, 0, -height2]) cylinder(height2, awg, awg);
        // second wire hole
        translate([0, 0, height2-awg/2.]) rotate([45, -0, 180]) translate([0, 0, -height2]) cylinder(height2, awg, awg);
    }
}


//2d regular polygone
module regular_polygone(sides,size)
{
	angle=360/sides;
	d=size/2/tan(angle/2);
	hull()
		for (i=[1:sides])
		{
			rotate([0,0,i*angle])polygon(points=[[0,0],[-size/2,d],[size/2,d]]);
		}
}