// MIlling Station by rmarabini
$fn=200;



brim_hole_radius_inner = 7/2.; // hole radius smaller
brim_hole_radius_outter = 10/2.; // hole radius larger
brim_hole_radius_thickness = 3.5; // heigh large 
brim_number_of_holes = 12;
brim_hole_distance = 185/2.;
brim_radius = 200/2.;      // Radius of the brim
brim_thickness = 5;    // Thickness of the brim

hat_height = 64 - brim_thickness;       // Total height of the hat
hat_radius = 160/2;       // Radius of the main part of the hat
hat_thickness = 5;     // Wall thickness of the hat

base_thickness = 2; // 4; ROBB
base_number_of_holes = brim_number_of_holes;
base_hole_distance = 110/2.;
base_hole_radius =  15/2.;

base_inner_circle = 69 /2.;
base_outter_circle = 84 /2.;
base_pie_angle = 55. ;

base_rectangle_base = 30;
// Brim (Bottom Flat Cylinder)
module brim(){
    color([0,0,1])
    difference() {
        // Main cylinder
        cylinder(h = brim_thickness, r = brim_radius);

        // Loop to create holes around the perimeter
        for (i = [0 : 360 / brim_number_of_holes : 360 - (360 / brim_number_of_holes)]) {
            rotate([0, 0, i])
            translate([brim_hole_distance, 0, 1.5])
            union()
            {
            cylinder(h = brim_thickness, 
                     r = brim_hole_radius_outter);
            translate([0, 0, -2])
            cylinder(h = brim_thickness, 
                     r = brim_hole_radius_inner);
            } // union
        } // for
    cylinder(h = brim_thickness, r = hat_radius - hat_thickness);

    } // diffrence
} // brim end

module pie(radius, angle, height, spin=0) {
	// calculations
	ang = angle % 360;
	absAng = abs(ang);
	halfAng = absAng % 180;
	negAng = min(ang, 0);

	// submodules
	module pieCube() {
		translate([-radius - 1, 0, -1]) {
			cube([2*(radius + 1), radius + 1, height + 2]);
		}
	}

	module rotPieCube() {
		rotate([0, 0, halfAng]) {
			pieCube();
		}
	}

	if (angle != 0) {
		if (ang == 0) {
			cylinder(r=radius, h=height);
		} else {
			rotate([0, 0, spin + negAng]) {
				intersection() {
					cylinder(r=radius, h=height);
					if (absAng < 180) {
						difference() {
							pieCube();
							rotPieCube();
						}
					} else {
						union() {
							pieCube();
							rotPieCube();
						}
					}
				}
			}
		}
	}
}

module base(){
    difference() {
        union(){
        color([1,0,0])
        cylinder(h = base_thickness , r = hat_radius);
        color([0,1,0])
        translate([0,0, base_thickness]){
        cylinder(h = base_thickness , r = hat_radius);
        }
    }
        // Loop to create holes around the perimeter
        for (i = [0 : 360 / base_number_of_holes : 360 - (360 / base_number_of_holes)]) {
            rotate([0, 0, i + (180 / base_number_of_holes)])
            translate([base_hole_distance, 0, -0.1])
            union()
            {
            cylinder(h = base_thickness, 
                     r = base_hole_radius, $fn = 100);
            //translate([0, 0, -2])
            //cylinder(h = brim_thickness, 
            //         r = brim_hole_radius_inner, $fn = 100);
            } // union
        } // for
        translate([0,0, 0]){
        cylinder(h = base_thickness , r = base_inner_circle);
        }
        intersection(){
            translate([0,0, 0]){
                cylinder(h = base_thickness , r = base_outter_circle);
            }
        union(){
        translate([-base_rectangle_base/2,-base_outter_circle,0])
            cube([base_rectangle_base,base_outter_circle*2,base_thickness]);
        translate([-base_outter_circle, -base_rectangle_base/2,0])
            cube([base_outter_circle*2,base_rectangle_base,base_thickness]);
        }//union
        }// intersect
        //pie(radius=10, angle=-260, height=5, spin = 0);
        } // diffrence
} // base

module hat(){
    difference() {
        cylinder(h = hat_height, r = hat_radius);   
        // Inner cylinder to hollow out, leaving the top solid
        cylinder(h = hat_height, r = hat_radius - hat_thickness);
    
    }
}

module main_hat(){
    difference() {
        union(){
            hat();
            translate([0,0,hat_height- hat_thickness * 2])
                base();
            translate([0, 0, -brim_thickness])
                brim();
        } // union end
        // cut for visualization REMOVE before printing
        // translate([-1,-1,-1]){
        //    cube([100,100,100]);
        //    }
    } // difference end
} // main_hat end

// main_hat();
//hat();
//main_hat();
//brim();

base();




//pie(radius=10, angle=-260, height=5, spin = 0);
//pie(radius=15, angle=25, height = 10, spin = 30);