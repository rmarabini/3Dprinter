include <puzzlecutlib.scad>

//import("Base_Right.stl");
//translate([0,16,0])
//import("Base_Middle.stl");
stampSize = [250,250,300];              //size of cutting stamp (should cover 1/2 of object)
//xCut1 = [-150, -100, -50, 0, 50, 100, 150];       //locations of puzzle cuts relative to X axis center
yCut1 = [81.75, 90.25];                               //for Y axis
kerf = -0.10;          //supports +/- numbers (greater value = tighter fit)
                                        //using a small negative number may be useful to assure easy fit for 3d printing
                                        //using positive values useful for lasercutting
                                        //negative values can also help visualize cuts without seperating pieces
                                        
p = 6;
m = 6; 
cutSize = 5.5;	//size of the puzzle cuts

cutInTwo(); //cuts in two along y axis
module cutInTwo()
{

     /*   translate([-m,0,0])
        yFemaleCut()  drawOcto1();
        translate([m,0,0])
        yMaleCut()  drawOcto1();
    */
    
        //translate([-m,0,0])
        //yFemaleCut() drawOcto2();
        translate([m,0,0])
        yMaleCut() drawOcto2();

}

module drawOcto1()
{
            translate([189,70,0])
            import("Base_Left.stl");

    }
    
module drawOcto2()
{
            translate([-194,70,0])
            import("Base_Right.stl");

    }