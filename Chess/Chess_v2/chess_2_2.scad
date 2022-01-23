//OpenSCAD PuzzleCut Library Demo - by Rich Olson
//http://www.nothinglabs.com
//Tested on build 2015.03-2
//License: http://creativecommons.org/licenses/by/3.0/

//!!!!!
//IMPORTANT NOTE: Puzzlecut only works correctly when RENDERING (F6)!  Preview (F5) will not produce usable results!
//!!!!!
mode = 4;
include <puzzlecutlib.scad>
include <chess.scad>
stampSize = [340,340,100];		//size of cutting stamp (should cover 1/2 of object)

cutSize = 6;	//size of the puzzle cuts

//xCut1 = [-18 ,-6, 4]; //locations of puzzle cuts relative to X axis center
//yCut1 = [-4, 5, 16];	//for Y axis

xCut1 = [-140, -100, -60, -20, 20, 60, 100, 140];       //locations of puzzle cuts relative to X axis center
yCut1 = xCut1;       //locations of puzzle cuts 

kerf = -0.125;		//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces

//cutInTwo();	//cuts in two along y axis
//cutInEight();	//cuts in four along x / y axis
p = 6;
m = -6;
//cutInFour22();

module cutInFour22()
{
    
    if (mode == 1) {
	    translate([p,m,0])
		xMaleCut() yMaleCut() drawOcto22();
    } else if (mode == 2){
  	    translate([m,m,0])
		xMaleCut() yFemaleCut() drawOcto22();
    } else if (mode == 3) {
         translate([p,p,0])
		xFemaleCut() yMaleCut() drawOcto22();
    } else if (mode == 4){
     	translate([m,p,0])
	    xFemaleCut() yFemaleCut() drawOcto22();
    }
}

if (mode==0){    
    drawOcto22(); 
}
module drawOcto22()
{
	//import("chess.stl");
    chessBoard();
}