include <pcb.scad>
drillHoleRad = 2; 
holeDiam = 1.125; // thru hole diameter in mm
holeLenX = holeDiam;
holeLenY = holeDiam;
on = true;
 
// if two Wires in One Hole
//holeLenY = holeDiam + .9;
 
holeSpace=2.54; // thru hole spacing in mm
// Nore: .1 inch = .0254 centimeters
  
// thickness of the board 
materialThick = 1.5; //2.54; // mm
 
// depth of the troughs 
inset = materialThick *.5; 
deepInset = materialThick *.5; 

difference(){
createboard2(16, 18, "Green");    
    { 
    // reed diodes  controler  
    ic_row=2;
    ic_col=2;    
    ic(ic_row, ic_col, ic_row + 14, ic_col + 4, false);
    // led matrix controler
    ic(ic_row, ic_col + 6, ic_row + 14, ic_col + 14, true);
    // power coontroler
    con1_row = -0.5;
    con1_col = 7;
    ic(con1_row, con1_col, con1_row+2, con1_col, true); 
    // serial line
    line1_row = 3;
    line1_col = 18;
    ic(line1_row, line1_col, line1_row+2, line1_col, true); 
        
    //GRN
       underwire(con1_row + 1, con1_col, ic_row, ic_col + 6, neg, on);
       underwire(con1_row + 1, con1_col, ic_row + 4, con1_col, neg, on);
       underwire(ic_row + 4, con1_col, ic_row + 4, ic_col + 4, neg, on);
       underwire(ic_row + 4, ic_col + 4, ic_row + 2, ic_col , neg, on);
       underwire(ic_row + 2, ic_col, ic_row + 1, ic_col , neg, on);
    //POS
       underwire(con1_row , con1_col, ic_row, ic_col + 14, pos, on);
       underwire(con1_row , con1_col, ic_row, ic_col , pos, on);
       underwire(ic_row, ic_col, ic_row, ic_col-1, pos, on);
       underwire(ic_row, ic_col-1, ic_row+3, ic_col-1, pos, on);
       underwire(ic_row+3, ic_col-1, ic_row+3, ic_col, pos, on);
       underwire(ic_row+3, ic_col, ic_row+5, ic_col+4, pos, on);
     //serial
     underwire(line1_row, line1_col, ic_row+1, ic_col + 14, yellowled, on); // sda
     underwire(line1_row+1, line1_col, ic_row+2, ic_col + 14, trace, on); // scl
     underwire(ic_row+1, ic_col+14, ic_row+1, ic_col + 4, yellowled, on); // sda
     underwire(ic_row+2, ic_col+14, ic_row+2, ic_col + 4, trace, on); // scl
//     underwire(line1_row+1, line1_col, ic_row+2, ic_col + 14, trace, on); // scl
     
    }
} // difference 

//createboard3(16, 18, "Green");    
