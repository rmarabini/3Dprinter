$fn=60;//30;
square_dim=40; // square size
size =8;

dim = size * square_dim;
frame_width=10;
top_left = [0, 0];
top_right = top_left + [size * square_dim, 0] + [frame_width/2., 0];
bottom_left = top_left + [0, size * square_dim, 0] + [0, frame_width/2.];
bottom_right = top_left + [size * square_dim, size * square_dim] + [frame_width/2., frame_width/2.];
height = 3.5;
square = false; // print square
board = true; // print board 
R = 6.4;
if (true){
    R = 6.4 + 0.1; // aux circle radius
}
if (board==true){
    R = 6.4; // aux circle radius
}
fen_x = size; // fenestrations on x axis
fen_y = size; // fenestrations on y axis

font1 = "Liberation Sans"; // here you can select other font type
 
hole_reed_1 = 3;
hole_led = square_dim - 5;
pcb_hole = 0.75;
//==== led
ledRadius = 2.5 ;//+ 0.05;


module escaque(){
        union(){
        translate([.5,.5,.8])
        cube([square_dim-1.75,square_dim-1.75,1]);
        translate([square_dim/2 - square_dim*5/16,
                   square_dim/2 - square_dim*5/16,- 1.8])
        cube([square_dim*5/8,square_dim*5/8,2.5]);
        }
}
module escaqueW(){
        color("white", 1){
        escaque();
    }
}
module escaqueB(){
        color("black", 1){
        escaque();
    }
}


    
module mySquare(){
//for(x=[-4:1:3]){
//    for(y=[-4:1:3]){
for(x=[0:1:0]){
    for(y=[0:1:0]){
       
 translate([x* square_dim , y * square_dim, 1]) 
        difference(){
        //if ((abs(x)+abs(y))%2 == 1){
        //    escaqueB();}
        //else{
        //    escaqueW();}
            
            
        //led
        t3 = [hole_led, hole_led, 0];
        translate(t3+ [0,0,offset])
        //cylinder(r=ledRadius+0.1, h=h+2);
        cylinder(r=ledRadius+0.1, h=0);
        }
    }
}
}// if squre end

module nodes(){
    // print small circle in square corner
    for (i = [0:fen_x - 1]) {
        for (j = [0:fen_y - 1]) {
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim,0])
                 circle(r=R/2); 
            }
        }
};

module auxLines(){
    ancho=14;
    for (i = [-2:1:2]){
        translate([0,square_dim * 2 * i, 0])
           square([dim,ancho],center=true);
        translate([square_dim * 2 * i, 0, 0])
           square([ancho, dim],center=true);
    }

}

module diagonals1()
{
    //print diagonals
    for (i = [1:size-1]){
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [i*square_dim, 0, 0])
                square(R);
            translate([-dim/2.-R, -dim/2.-R, 0] + 
                      [dim, dim - i*square_dim, 0])
                square(R);
        }
         hull(){
            translate([-dim/2., -dim/2., 0] + 
                      [0, i*square_dim, 0])
                square(R);
            translate([-dim/2.-R, -dim/2.-R, 0] + 
                      [dim -i*square_dim, dim, 0])
                square(R);
        }
    }

    hull(){
         translate([-dim/2., -dim/2., 0] + 
                   [0, 0, 0])
                square(R);
         translate([-dim/2.-R, -dim/2.-R, 0] + 
                   [dim, dim, 0])
                square(R);
        }

};
module diagonals2()
{
    //print diagonals
    for (i = [1:size-1]){
         hull(){
            translate([-dim/2.-R, -dim/2., 0] + 
                      [i*square_dim, 0, 0])
                square(R);
            translate([-dim/2., -dim/2.-R, 0] + 
                      [0, i*square_dim, 0])
                square(R);
        }
         hull(){
            translate([-dim/2.-R, -dim/2., 0] + 
                      [i*square_dim+R, dim-R, 0])
                square(R);
            translate([-dim/2.-R, -dim/2., 0] + 
                      [dim, i*square_dim, 0])
                square(R);
        }
    }

    hull(){
         translate([-dim/2., -dim/2., 0] + 
                   [dim-R, 0, 0])
            square(R);
         translate([-dim/2., -dim/2., 0] + 
                   [0, dim-R, 0])
            square(R);
        }

};

module _line(p1, p2, r=1.5, color = [1,1,0], z=0)
{
    //print a cylinder from p1 to p2
    color(color)
      hull(){
        translate(p1+[0,0,-0.75+z])
        cylinder(r=r, h=h);
        translate(p2+[0,0,-0.75+z])
        cylinder(r=r, h=h);
      }
};

module screw(){
    import ("M3_screw.stl"); 
    };
    
    
module screewloop(){
    for (i = [0:1:fen_x - 1]) {
        for (j = [0:1:fen_y - 1]) {
            //
            t1 = [-dim/2., -dim/2., -1] + 
                      [i*square_dim, j*square_dim, 6.0] 
                      + [square_dim*3/4., square_dim*1/4, -h/2-1.3];
            translate(t1)
            rotate([0,180,0])
                 screw(); 
 
        }
    }
}; 

module diagonals(){
    union(){    
    diagonals1();
    diagonals2();
    }
}

module grid(){
linear_extrude(height = height, center = true, convexity = 10, twist = 0)
    union(){
        diagonals();
  //    nodes();
        auxLines();
    }
}


h = height;
offset=-h;
module holes(){
    // print holes for components
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
                       hole_reed_1+square_dim*12/24., 0]
                       +[1, -1, 0];
            translate(t4+ [0,0,offset])
            cylinder(r=pcb_hole, h=h+2);
           
            t5 = [-dim/2., -dim/2., 0] + 
                      [i*square_dim, j*square_dim, 0] +
                      [ -hole_reed_1+square_dim*8/24., 
                       +hole_reed_1+square_dim*16/24., 0];
            translate(t5+ [0,0,offset])
            cylinder(r=pcb_hole, h=h+2);

           //reed space
            _line(t1, t2, r=1.1);  // small filament
            _line(t1-(t2-t1), t2 + (t2-t1), r=0.7, z = .8);
            //echo("t2-t1", (t2-t1)*4.4/8.);
           //diod space is 
            _line(t4, t5, r=.75);
        //echo(t1);
        //echo(t2);
        //echo(t3);
        //echo(t4);
        //echo(t5);
            }
        }

        screewloop();
}

module letters(texto){ //X 
    for (i = [0:fen_x - 1]) {
        translate([-dim/2.+square_dim/2., -dim/2.-frame_width*3/4.+0, -h/2] + 
                  [i*square_dim-2, 0,h-1])
            //rotate([0,0,90])
                linear_extrude(2)
                text(texto[i], font = font1, size = frame_width - 4,
                    spacing = 1 );
    }   
}

module numbers(numero){ //1 
    //print 1,2,3 in y axis
    for (i = [0:fen_y - 1]) {
        translate([-dim/2.-frame_width*3/4.+0, -dim/2.+square_dim/2., -h/2] + 
                  [0, i*square_dim-2, h-1])
            //rotate([0,0,90])
                linear_extrude(2)
                text(numero[i], font = font1, size = frame_width - 4,
                    spacing = 1 );
                     }   
            }
         
   
module frame00(texto, numero){
    hprimma=1;
    translate([0,0,hprimma/2.])
    difference(){
        linear_extrude(height = height+hprimma, center = true, convexity = 10, twist = 0)
            {
            difference(){
                square(dim + 2 * frame_width, center=true);
                square(dim, center=true);
               }
            }
    translate([0,0,0])    
    union(){   
        letters(texto);
        numbers(numero);
    }//uni
    }//diff
}//frame00


module drawDemoObject(){
 difference(){
    union(){
        frame00("ABCDEFGH", "12345678");
        grid();
    }
    union(){
        holes();
            // add T
    }
 }
}

if (board){
drawDemoObject();
}
//
difference(){
   mySquare();
   grid();     
}
//drawDemoObject();

