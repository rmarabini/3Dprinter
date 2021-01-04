// Internal diameter of holes
internal_diameter = 3.0;

// External diameter of pillar
external_diameter = 8;

// Minimum wall thickness of pillars
minimum_wall_thickness = 1;

// Distance between holes on X axis
width = 75;

// Distance between holes on Y axis
length = 115;

// Height of pillars
height = 5;

// Number of cylinder segments
hole_segments = 40;

// Height of connecting strips
strip_height = 2;

// Internal radius of holes
internal_radius = internal_diameter / 2;

// External radius of pillars is limited by the minimum wall thickness
external_radius = max(external_diameter / 2, internal_radius + minimum_wall_thickness);

// Width of the connecting strips
strip_width = external_radius;

// prevents the connecting strips from encroaching on the holes
clearance = internal_diameter + 0.05;

module hide_parameters_below_this_point() {}

// prevents coplanar polygons on cylinder subtraction
fudge = 0.05;



//HEX

module hex(hole, wall, thick){
    hole = hole;
    wall = wall;
    difference(){
        rotate([0, 0, 30]) cylinder(d = (hole + wall), h = thick, $fn = 6);
        translate([0, 0, -0.1]) rotate([0, 0, 30]) cylinder(d = hole, h = thick + 0.2, $fn = 6);
    }
}



module hexgrid(box, holediameter, wallthickness) {
    a = (holediameter + (wallthickness/2))*sin(60);
    for(x = [holediameter/2: a: box[0]]) {
        for(y = [holediameter/2: 2*a*sin(60): box[1]]) {
            translate([x, y, 0]) hex(holediameter, wallthickness, box[2]);
            translate([x + a*cos(60), y + a*sin(60), 0]) hex(holediameter, wallthickness, box[2]);

        }
    }
        
}


union() {
    for (y=[-1:2:1]) {
        for (x=[-1:2:1]) {
            // subtract two cylinders to make a pillar
            difference() {
                // outside of cylinder
                translate([x*width/2,y*length/2,0]) {
                    cylinder(r=external_radius, height, $fn=hole_segments); 
                }
                // inside of cylinder
                translate([x*width/2,y*length/2,-fudge/2]) {
                    cylinder(r=internal_radius, height+fudge, $fn=hole_segments); 
                }
            }
            // connect along Y axis
            translate([x*width/2,0,strip_height/2]) {
                cube([strip_width,length-clearance,strip_height],center=true);
            }
        }
        // connect along X axis
        translate([0,y*length/2,strip_height/2]) {
             cube([width-clearance,strip_width,strip_height],center=true);
        }
    }
    // first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 
//translate([-(width)/2.,-(length)/2,0])
//hexgrid([width - clearance, length-clearance-1,strip_height], 20, 4);
}


