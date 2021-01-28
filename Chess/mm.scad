//OpenSCAD PuzzleCut Library Demo - by Rich Olson
//http://www.nothinglabs.com
//Tested on build 2015.03-2
//License: http://creativecommons.org/licenses/by/3.0/

//!!!!!
//IMPORTANT NOTE: Puzzlecut only works correctly when RENDERING (F6)!  Preview (F5) will not produce usable results!
//!!!!!
mode=1;
mode2=1;
include <puzzlecutlib.scad>

stampSize = [190,190,100];		//size of cutting stamp (should cover 1/2 of object)

cutSize = 6;	//size of the puzzle cuts

//xCut1 = [-18 ,-6, 4]; //locations of puzzle cuts relative to X axis center
//yCut1 = [-4, 5, 16];	//for Y axis

xCut1 = [-60, -20, 20, 60];       //locations of puzzle cuts relative to X axis center
yCut1 = xCut1;       //locations of puzzle cuts 

kerf = -0.15;		//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces

//cutInTwo();	//cuts in two along y axis
//cutInEight();	//cuts in four along x / y axis
cutInFour();

p = 6;
m = -6;
module cutInFour()
{
    if (mode==1){
   	    translate([p,m,0])
		xMaleCut() yMaleCut() drawOcto();
    } else if (mode==2){
    	translate([m,m,0])
		xMaleCut() yFemaleCut() drawOcto();
    } else if (mode==3){
    	translate([p,p,0])
		xFemaleCut() yMaleCut() drawOcto();
    } else if (mode == 4){
    	translate([m,p,0])
		xFemaleCut() yFemaleCut() drawOcto();
    }
}

if (mode==0){
    drawOcto();
}

module drawOcto()
{
    if (mode2==1){
        translate([85,85,0])
	    import("mm.stl");
    } else if (mode2==2){
        translate([-85,-85,0])
	    import("pp.stl");
    } else if (mode2==3){
        translate([85,-85,0])
	    import("mp.stl");
    } else if (mode2 == 4){
        translate([-85,85,0])
	    import("pm.stl");
    }
}