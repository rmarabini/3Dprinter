$fn=100;
//import("files/Minimalist_Laser_Microscope_End_Cap.stl");
/*
translate([0,-27,0]){
import("files/Minimalist_Laser_Microscope_Body.stl");
}
*/
/*

difference(){
    translate(v=[-18,0, 8.85]){
        rotate(90, [0,1,0]){
           cylinder(h = 14, r = 8);
            }
        }///trnaslate end
    translate(v=[-18,0, 8.85]){
        rotate(90, [0,1,0]){
           cylinder(h = 14, r = 5.1);
            }
        }///trnaslate end
            
}//difference end
*/





ech = 11; // cylinder end cap height
ecr = 26 ; // cylinder end cap radius

laserRadius = 5; // laser radius
syringeRadius = 16.5 / 2 ; // srynge radius
syringeRadius1 = 16.5/2; //9.5 /2  ; // srynge radius at syringeHeight1
syringeRadius2 = 2  ; // srynge radius at syringeHeight1

syringeHeight = 58.5 +15; // srynge height
syringeHeight1 = 15 + 15; //
syringeHeight2 = 18; //
syringeHeight3 = 25; //

module cap(){
    translate(v=[0,0,50]){
        difference(){
            cylinder(h = ech, r = ecr);
            translate(v=[-ecr,0,0]){
                cube([ecr*2, ecr, ech]);
            }
            translate(v=[0,-laserRadius - 5, 0]){
                cylinder(h = ech *3 / 4., r = laserRadius);
            }
        }
    }
}


module front(){
    translate(v=[0,0,-50]){ // t1
        difference(){
            //base
            union(){ //u1
                cylinder(h = 2.5*ech, r = ecr);
                translate(v=[0,-laserRadius - 5, ecr/4 + 4]){
                    rotate(90, [1,0,0]){
                        cylinder(h = syringeHeight, r = syringeRadius+2);
                    } // rot
                }// tran
            } //union u1end  

            translate(v=[-ecr*1.5,0,0]){
                cube([ecr*2.5, ecr, 2.5*ech]);
            }
            //laser hole
            translate(v=[0,-laserRadius - 5, ech*2-2.5]){
                cylinder(h = ech *3 / 4., r = laserRadius);
            }
            //pasing laser hole
            translate(v=[0,-laserRadius - 5, 0]){
                cylinder(h = ech*2.5, r2 = laserRadius*5/8.,
                                      r1 = laserRadius*6/4.);
            }
            //srynge level 1
            translate(v=[0,-laserRadius - 5 - syringeHeight + syringeHeight1 , ecr/4 + 4]){
                rotate(90, [1,0,0])
                    cylinder(h = syringeHeight1+15, r = syringeRadius);
                }
            //srynge level 2
            translate(v=[0,-laserRadius - 5 - syringeHeight + syringeHeight1 + syringeHeight2  , ecr/4 + 4]){
                rotate(90, [1,0,0])
                    cylinder(h = syringeHeight2, r = syringeRadius1);
                }
            //srynge level 3
            translate(v=[0,-laserRadius - 5 - syringeHeight + syringeHeight1 + syringeHeight2  + syringeHeight3  , ecr/4 + 4]){
                rotate(90, [1,0,0])
                    cylinder(h = syringeHeight3, r = syringeRadius2);
                }
        } // difference end

        
  } // translate t1 end
}

//cap();
front();