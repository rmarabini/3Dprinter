$fn=15;//30;
square_dim=40; // square size
frame_width=12;
top_left = [0, 0];
top_right = top_left + [8 * square_dim, 0] + [frame_width/2., 0];
bottom_left = top_left + [0, 8 * square_dim, 0] + [0, frame_width/2.];
bottom_right = top_left + [8 * square_dim, 8 * square_dim] + [frame_width/2., frame_width/2.];
h = 5;
R = frame_width/2. -2; // aux circle radius

fen_x = 8; // fenestrations on x axis
fen_y = 8; // fenestrations on y axis

font1 = "Liberation Sans"; // here you can select other font type
 
hole_reed_1 = 3;
hole_led = square_dim - 5;
pcb_hole = 1.;
//==== led
ledRadius = 2.5 + 0.1;

module frame(){
    difference()
    {
        dimF = 8 * square_dim + frame_width * 2;
        dim  = 8 * square_dim ;
        translate([0,0,+h/2.+1/2.])
        cube([dimF, dimF, h+2], center=true);
        translate([0,0,-1+h/2+1/2.])
        cube([dim, dim, h+4+2], center=true);     
    }
};

module letters(){ //X 
    // print a,b,c.. in x axis
    values= "ABCDEFGH"; 
    dim  = 8 * square_dim ;
    for (i = [0:fen_x - 1]) {
        translate([-dim/2.+square_dim/2., -dim/2.-frame_width*3/4., 0] + 
                  [i*square_dim, 0,h])
            //rotate([0,0,90])
                linear_extrude(2)
                text(values[i], font = font1, size = frame_width - 4,
                    spacing = 1 );
                     }   
            }
        
module numbers(){ //1 
    //print 1,2,3 in y axis
    values= "12345678"; 
    dim  = 8 * square_dim ;
    for (i = [0:fen_y - 1]) {
        translate([-dim/2.-frame_width*3/4., -dim/2.+square_dim/2., 0] + 
                  [0, i*square_dim, h])
            //rotate([0,0,90])
                linear_extrude(2)
                text(values[i], font = font1, size = frame_width - 4,
                    spacing = 1 );
                     }   
            }

module auxLines(){
    // print squares skeleton
    dim  = 8 * square_dim ;
    fen_size = 46; // size of fenestrations as a % of total axis size

    fen_size_x = fen_size * dim / 100;
    fen_size_y = fen_size * dim / 100;
    // calculate space remaining and then divide by number of windows needed + 1 to get the desired size of the struts
    fen_x=2; fen_y=2;
    strut_x = (dim - fen_x * fen_size_x) / (fen_x + 1);
    strut_y = (dim - fen_y * fen_size_y) / (fen_y + 1);
    
    // take away windows from fenestrated surface
    difference() {
        translate([-dim/2., -dim/2.0,0])
        cube(size=[dim, dim, h]); // fenestrated surface
        for (i = [0:fen_x - 1]) {
            translate([-dim/2., 0, 0] + 
                      [i * (fen_size_x + strut_x) + strut_x, 0, 0])
            for (j = [0:fen_y - 1]) {
                 translate([0, -dim/2., 0] + 
                          [0, j * (fen_size_y + strut_y) + strut_x, -1])
                     cube([fen_size_x, fen_size_y, h+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
            }
        }
    }
};

module nodes(){
    // print small cylinder in square corner
    dim  = 8 * square_dim ;
    for (i = [0:fen_x - 1]) {
        for (j = [0:fen_y - 1]) {
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim,0])
                 cylinder(r=R, h=h); 
            }
        }
};

module diagonals1()
{
    //print diagonals
    dim  = 8 * square_dim ;
    for (i = [1:7]){
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, 0, 0])
                cylinder(r=R, h=h);
            translate([-dim/2., -dim/2., 0] + 
                      [dim, dim - i*square_dim, 0])
                cylinder(r=R, h=h);
        }
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [0, i*square_dim, 0])
                cylinder(r=R, h=h);
            translate([-dim/2., -dim/2., 0] + 
                      [dim -i*square_dim, dim, 0])
                cylinder(r=R, h=h);
        }
    }
    hull(){
         translate([-dim/2., -dim/2., 0] + 
                   [0, 0, 0])
            cylinder(r=R, h=h);
         translate([-dim/2., -dim/2., 0] + 
                   [dim, dim, 0])
            cylinder(r=R, h=h);
        }

};

module diagonals2()
{
    //print diagonals
    dim  = 8 * square_dim ;
    for (i = [1:7]){
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, 0, 0])
                cylinder(r=R, h=h);
            translate([-dim/2., -dim/2., 0] + 
                      [0, i*square_dim, 0])
                cylinder(r=R, h=h);
        }
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, dim, 0])
                cylinder(r=R, h=h);
            translate([-dim/2., -dim/2., 0] + 
                      [dim, i*square_dim, 0])
                cylinder(r=R, h=h);
        }
    }
    hull(){
         translate([-dim/2., -dim/2., 0] + 
                   [dim, 0, 0])
            cylinder(r=R, h=h);
         translate([-dim/2., -dim/2., 0] + 
                   [0, dim, 0])
            cylinder(r=R, h=h);
        }

};

module _line(p1, p2, r=1.5, color = [1,1,0])
{
    //print a cylinder from p1 to p2
    color(color)
      hull(){
        translate(p1+[0,0,h/2])
        cylinder(r=r, h=h);
        translate(p2+[0,0,h/2])
        cylinder(r=r, h=h);
      }
};

module screw(){
    import ("M3_screw.stl"); 
    };
    
module screewloop(){
    dim  = 8 * square_dim ;
    for (i = [0:1:fen_x - 1]) {
        for (j = [0:1:fen_y - 1]) {
            //reed1
            t1 = [-dim/2., -dim/2., -1] + 
                      [i*square_dim, j*square_dim, 6.0] 
                      + [square_dim*3/4., square_dim*1/4, 0];
            translate(t1)
            rotate([0,180,0])
                 screw(); 
 
    }
}};    
offset=0.2;
module holes(){
    // print holes for components
    dim  = 8 * square_dim ;
    for (i = [0:fen_x - 1]) {
        for (j = [0:fen_y - 1]) {
            //reed1
            t1 = [-dim/2.+4, -dim/2.+4, 0] + 
                      [i*square_dim, j*square_dim, 0] 
                      + [1.5, 1.5, 0];
            translate(t1+ [0,0,offset])
                 cylinder(r=pcb_hole, h=h+2); 
            //reed2
            t2 = [-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim, 0]
                       + [+square_dim/2., 
                       +square_dim/2., 0];
            translate(t2+ [0,0,offset])
                 cylinder(r=pcb_hole, h=h+2);
           //led
            t3 = [-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim, 0]
                      + [hole_led, hole_led, 0];
            translate(t3+ [0,0,offset])
            cylinder(r=ledRadius, h=h+2);

           //diodo
            t4 = [-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim, 0] +
                      [-hole_reed_1+square_dim*12/24., 
                       hole_reed_1+square_dim*12/24., 0];
            translate(t4+ [0,0,offset])
            cylinder(r=pcb_hole, h=h+2);
           
            t5 = [-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim, 0] +
                      [ -hole_reed_1+square_dim*8/24., 
                       +hole_reed_1+square_dim*16/24., 0];
            translate(t5+ [0,0,offset])
            cylinder(r=pcb_hole, h=h+2);

           //reed space
            _line(t1, t2);
           //diod space is 
            _line(t4, t5);
        //echo(t1);
        //echo(t2);
        //echo(t3);
        //echo(t4);
        //echo(t5);
            }
        }

        screewloop();
}
module PCB()
{
    difference(){
        union(){
            frame();
            diagonals1();
            diagonals2();
            auxLines();
        }
        holes();
    }
};


module chessBoard(){
  difference(){
   union(){
      //frame();
      //auxLines();
      PCB();   
      //nodes(); 
   }
   union(){
      letters();
      numbers();
   }
  }
};

/*
intersection() {
    translate([square_dim+5, square_dim+5, 0])
       rotate([0,0,0])
       cube([1000,1000,100]);
       //cube([1000,1000,100], center=true);
    chessBoard();
} 
*/

intersection() {
    //translate([-square_dim+5, -square_dim+5, 0])
       //rotate([0,0,0])
       //rotate([0,0,90])
       //rotate([0,0,180])
       rotate([0,0,270])
       cube([1000,1000,100]);
       //cube([1000,1000,100], center=true);
    chessBoard();
} 

//chessBoard();
