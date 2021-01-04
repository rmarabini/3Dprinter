/*
Project: SRAM GXP Pressfit Bottom Bracket Tool 12mm Rod
Version: 1.0
Design: Lubosh.Occ
Published: 30/06/18 (mm/dd/yy)
License: Creative Commons - Attribution - NonCommercial - ShareAlike  (CC BY-NC-SA 4.0)

Details: Drive Side, Non-Drive Side and Frame Plate with opening for 12mm threaded rod to install SRAM GXP Pressfit Bottom Bracket. I've used 20cm of threaded rod, blocked one side with 2 nuts thatr are tightened agains each other, then follow by big thick penny washer to help spread the pressure on the plates during installation, then the plates according to installation instructions, followed by another washer and a nut which will be tightened during installation to push the BB in the frame.

Design No.: 004 - this is the fourth design than I'm publishing. I'm sure the code can be simplified, optimized etc. - feel free to do so! I'll upload new & hopefully better version when I can think of a better way of doing some stuff.

I've tried to put comments - it's not perfect but some comments are there to help navigate the code - there is 1000 better ways :)

I've tried to make it as parametric as I'm capable of. Where you see numbers instead of variables, that is where I couldn't think of a formula to use instead or it made no sense to do so - feel free to figure it out and let me know.

I've done several test prints in ABS and it fits nicely the GXP Pressfit that I'm using and the 12mm threaded rod. If you need to modify some sizes, which should really be no other that the Driver Side Bearing ID, Non-Driver Side Bearing ID and the Frame Cup ID see the variable comments bellow. 

IT'S NOT PERFECT, IT WORKS :)
*/

$fn = 200;
flyr = 0.3;
lyr = 0.2;

bev = 1.5;

m = 10.2; // Threaded rod Dia - measured with calliper, might need to be modified if different tolerances rod is used

ds = 23.5; //23.94  // DRIVE SIDE BEARING ID
ds_h = 7.1;

nds = 21.5; //22.2 // NON-DRIVE SIDE BEARING ID

frame_in = 40.8; //40.8; // FRAME CUP ID
cup_out = 44.2; // Outside Diameter of the plates

cup_edw = 6.25;
cup_edh = 2;

// Drive Side Plate
module drive_side(){
    difference(){
        union(){
            difference(){
                cylinder(h=ds_h, d=cup_out);
                translate([0,0,ds_h-cup_edh]){
                    cylinder(h=cup_edh, d=cup_out-2*cup_edw);
                }
            }
            translate([0,0,ds_h-cup_edh]){
                cylinder(h=ds_h-bev+cup_edh, d=ds);
                translate([0,0,ds_h-bev+cup_edh]){
                    cylinder(h=ds_h, d1=ds, d2=ds-4*bev);
                }
            }
        }
        cylinder(h=3*ds_h,  d=m);
    }
}

//Non Drive Side Plate
module ndrive_side(){
    difference(){
        union(){
            difference(){
                cylinder(h=ds_h, d=cup_out);
                translate([0,0,ds_h-cup_edh]){
                    cylinder(h=cup_edh, d=cup_out-2*cup_edw);
                }
            }
            translate([0,0,ds_h-cup_edh]){
                cylinder(h=ds_h-bev+cup_edh, d=nds);
                translate([0,0,ds_h-bev+cup_edh]){
                    cylinder(h=ds_h, d1=nds, d2=nds-3*bev);
                }
            }
        }
        cylinder(h=3*ds_h,  d=m);
    }
}

//Frame Plate
module plate(){
    difference(){
        union(){
            cylinder(h=ds_h, d=cup_out+2);
            translate([0,0,ds_h]){
                cylinder(h=bev, d=frame_in+0.2);
            }
            translate([0,0,ds_h+bev]){
                cylinder(h=bev, d1=frame_in+0.2, d2=frame_in-2*bev);
            }
            translate([0,0,ds_h+2*bev]){
                cylinder(h=ds_h+cup_edh, d1=m+10, d2=m+10-2*bev);
            }
        }
        cylinder(h=3*ds_h,  d=m);
        translate([0,0,2*cup_edh]){
            difference(){
                cylinder(h=ds_h, d=frame_in-4*bev);
                cylinder(h=ds_h, d=m+10);
            }
        }
    }
}


/* bellow uncomment (remove the "//") the part you want to generate */ 

drive_side();
 //ndrive_side();
// plate();