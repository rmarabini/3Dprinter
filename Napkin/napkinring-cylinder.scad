use<write.scad>;

//Set The name to the word you want engraved on the ring
name="Roberto";

//Set nameCount to the number of times the word should be printed.
nameCount=2;

//Depth of the word
namedepth = 2;

//Height of ring
height=11; //18; // 22;

//Radius - Outside Diameter
radius=19; //25

//Thickness of wall
wall=3;

$fn=200;

difference()
{
	difference()
	{
		//Outside of ring
		cylinder(h=height,r=radius);
		//difference the name
		translate([0,0,height/2])
			//Loop nameCount times
			for (z = [0 : nameCount]) 
			{
				//Rotate 360/namecount for each iteration
				rotate([0,0,z * 360 / nameCount])
					//Write the Name
					writecylinder(name,[0,0,0],radius,t=namedepth, height=height/3*1.8, rounded=1);
			}		
	}
	//Remove Center
	translate([0,0,-1])cylinder(r=radius-wall, h=height+2);
	
};


