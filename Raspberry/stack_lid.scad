
// This is a remix from the awesome 
// Raspberry Pi Stackable Tray (https://www.thingiverse.com/thing:2187350)
// with a lot of reverse engineered code taken from
// Raspberry PI stack mount for Raspberry PI (https://www.thingiverse.com/thing:2883047).
//
// Like Miha Markic I preferred mounting the Rasperry Pi with screws.
// But I wanted to use M screws so I needed to modify the code for that.
//
// Additionally a added a cut for easier sd cards replacement for Raspberry 3 Pi and Odroid C2,
// moved the mounting holes a little bit so the Raspberry fits better into the case and
// made the wohle thing parametric so everyone can modify it to their special needs.

////////////////////////////////  Variables  ////////////////////////////////////

/* [General] */

// Resolution
$fn = 80;

// Base thickness
base_plate_height = 2.4;

// Total x width
outer_large_x = 91.5;

// Total y width
outer_large_y = 79.5;

// Long side width
long_side_width = 30;


/* [Pillars] */

// Diameter of the small pillar
small_pillar_diameter = 5.5;

// Diameter of the large pillar
large_pillar_diameter = 10;

// Height of the large pillar
large_pillar_height = 12;


// Gap size for stacking
delta = .6;

// Stacking hole depth
stacking_hole_depth = 10;


/* [hidden] */

// Avoid artifacts
clearance = 0.001;

// Calulated values

hole_full_d = small_pillar_diameter+delta;
between_pins_x = outer_large_x - large_pillar_diameter;
between_pins_y = outer_large_y - large_pillar_diameter;
horizontal_support_y = large_pillar_diameter/2;

center_scale = 100; //[30:120]
//////////////////////////////////  Build  //////////////////////////////////////

build();

/////////////////////////////////  Modules  ////////////////////////////////////

module build() {
    difference() {
        union() {
            quarter();
            translate([between_pins_x, 0]) {
                mirror([1, 0, 0]) quarter();
            }
            translate([0, between_pins_y]) {
                mirror([0, 1, 0]) quarter();
            }
            translate([between_pins_x, between_pins_y]) {
                mirror([1,0,0]) mirror([0,1,0]) quarter();
            }
        }
        
        // Rasperry Pi logo
        translate([15, 10,-1]) {
                     cube([
                    60,
                    long_side_width+10,
                    10
                ]);
        }

    }
}

module quarter() {

    difference() {
        union() {
            pin();

            // front and back parts
            rotate(90)
                translate([0, -large_pillar_diameter/2])
                    cube([between_pins_y/2, large_pillar_diameter, base_plate_height]);
            
            // side parts
            translate([0, horizontal_support_y, 0]) {
                cube([
                    between_pins_x/2,
                    long_side_width,
                    base_plate_height
                ]);
            }
        }

        // Stacking hole
        translate([0, 0, -clearance]) {
            pin_hole(stacking_hole_depth+2*clearance);
        }
    }
}

module pin() {
    union() {
        difference() {
            cylinder(d=large_pillar_diameter, h=large_pillar_height);
            pin_hole();
        }
    }
}

module pin_hole(h) {
    cylinder(d=hole_full_d, h=h);
}


//----------------------------------------------------------------------------
