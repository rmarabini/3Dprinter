$fn=64;
text = true;
// === BOARD  parameters ===
squareW = 40;
frameW = 8;
square_frameW = squareW + frameW;
Offset = frameW/2.;
ZOffset = 0;
h=1;

//base parameters
thick = 5;

//==== led
ledRadius = 2.5 + 0.25;


//=== reed
reedRadius = 1;
offsetReedsX = Offset - 10;
offsetReedsY = Offset + 10;

// font
font = "DejaVu Sans:style=Bold";
letter_size = 6;
height = 2;



// ==== List with hull points

points = [ for (i = [-1 : 1 : 2])
           for (j = [-1 : 1 : 2]) [j * square_frameW + Offset, 
                                  i * square_frameW + Offset, ZOffset] ];
//=== list leds
leds = [ for (i = [0 : 1 : 2])
           for (j = [-1 : 1 : 1]) [j * square_frameW + Offset, 
                                   i * square_frameW + Offset, ZOffset] ];
reeds1 = [ for (i = [-1 : 1 : 1])
           for (j = [0 : 1 : 2]) [j * square_frameW + offsetReedsX, 
                                   i * square_frameW + offsetReedsY, ZOffset] ];
reeds2 = [ for (i = [-1 : 1 : 1])
           for (j = [-1 : 1 : 1]) [j * square_frameW + Offset + square_frameW/2, 
                                   i * square_frameW + Offset + square_frameW/2 , 
                                   ZOffset] ];

long = reeds1[0] - reeds2[0];
echo("long");
echo(long);           
//for(p=points)
//    translate(p)
//        cylinder(r=frameW/2, h=h);


module _base(){
    baseOffset = 10;
    difference(){
    hull(){
        translate(points[0]+[-baseOffset,-2.5*baseOffset,-thick])
        cylinder(r=frameW/2, h=thick);
        translate(points[3]+[baseOffset,-2.5*baseOffset,-thick])
        cylinder(r=frameW/2, h=thick);
        translate(points[12]+[-baseOffset,0,-thick])
        cylinder(r=frameW/2, h=thick);
        translate(points[15]+[baseOffset,0,-thick])
        cylinder(r=frameW/2, h=thick);
    }
        //holes
        translate(points[0]+[-baseOffset,-2.5*baseOffset,-2*thick])
        cylinder(r=1.5, h = 15);
        translate(points[3]+[baseOffset,-2.5*baseOffset,-2*thick])
        cylinder(r=1.5, h = 15);
        translate(points[12]+[-baseOffset,0,-2*thick])
        cylinder(r=1.5, h = 15);
        translate(points[15]+[baseOffset,0,-2*thick])
        cylinder(r=1.5, h = 15);
        //adafruit LCD
        translate(points[3]+[-140 -2,-17, -2*thick])
        cube([37, 7, 20]);
        translate(points[3]+[-140,-15, -2*thick]+[0+2,-8.9 + 3.5,0])
        cylinder(r=1.5, h = 15);
        translate(points[3]+[-140,-15, -2*thick]+[75+2,-8.9 + 3.5,0])
        cylinder(r=1.5, h = 15);
        //translate(points[3]+[-140,-15, -2*thick]+[75+2,-8.9 + 3.5 - 31,0])
        //cylinder(r=1.5, h = 15);
        //translate(points[3]+[-140,-15, -2*thick]+[0+2,-8.9 + 3.5 - 31,0])
        //cylinder(r=1.5, h = 15);

  }
}

module _line(p1, p2)
{
      hull(){
        translate(points[p1])
        cylinder(r=frameW/2, h=h);
        translate(points[p2])
        cylinder(r=frameW/2, h=h);
      }    
}
module _wire(start, end, thickness = 1, color = [1,1,0]) {
    color(color)
    hull() {
        translate(start) sphere(thickness);
        translate(end) sphere(thickness);
    }
}

module _label(string){
    mirror(v=[1,0,0])
    rotate([0,0,90])
    linear_extrude(height) {
             text(string, size = letter_size, font = font, halign = "center", valign = "center", $fn = 64);
    }
}

module _led(){
difference(){
  union(){//union1
      for (i = [0 : 4 : 15])
        _line(i,i+3); //line frame
      for (j = [0 : 1 : 3])
        _line(j, j+12);//line frame
      _base(); //bottom frame
     }//union1
     union(){//union2
       for(l=leds) // led holes
          translate(l+[1,-1,-thick -1])
          cylinder(r=ledRadius, h=h+thick+2);
        mcp2317 = ["a7", "a6", "a5", "a4", "a3", "a2", "a1", "a0", "b0"];
        for (i = [0 : 1 : 2]) // led number
           for (j = [0 : 1 : 2])
              translate(leds[j+i*3] + [2* (ledRadius+ letter_size), 
                                       -2*ledRadius,
                                       -thick-1])	{
                       number =  j+i*3+1;
                       if (text)
                          _label(str(number, "-", mcp2317[number - 1]));
                                       }
        // catode number
        catodes=[[0, "C0"], [1, "C1"], [2, "C2"]];
        for(catode=catodes){   //catode labels
            translate(points[catode[0]] + [0, letter_size+2, -thick-1])	
              if (text)
                _label(catode[1]);
        }
        // anode number
        anodes=[[7, "A2"], [11, "A1"], [15, "A0"]];
        for(anode=anodes){   //anode labels
            translate(points[anode[0]] + [1* letter_size, 0, -thick-1])	
              if (text)
                _label(anode[1]);
        }
        shift66=[0,0,-1];
        for (i =[0:1:8]){
           _wire(reeds1[i]+shift66, reeds2[i]+shift66,2);
        }
       for(r1=reeds1) // reed holes 1
          translate(r1+[0,0,-thick -1])
          cylinder(r=reedRadius, h=h+thick+2);
       for(r2=reeds2) // reed holes 1
          translate(r2+[0,0,-thick -1])
          cylinder(r=reedRadius, h=h+thick+2);
        shift6=[0,0,-thick];
       _wire(reeds1[6]+shift6, reeds1[0]+shift6, 1, [0,0,0]);
       _wire(reeds1[0]+shift6, reeds1[1]+shift6, 1, [0,0,0]);
       _wire(reeds1[1]+shift6, reeds1[7]+shift6, 1, [0,0,0]);
       _wire(reeds1[7]+shift6, reeds1[8]+shift6, 1, [0,0,0]);
       _wire(reeds1[8]+shift6, reeds1[2]+shift6+[0,-10,0], 1, [0,0,0]);
        shift7=[0, -square_frameW/2,-thick];
       _wire(reeds2[6]+shift6, reeds2[0]+shift7, 2, [1,0,0]);
       _wire(reeds2[7]+shift6, reeds2[1]+shift7, 2, [1,0,0]);
       _wire(reeds2[8]+shift6, reeds2[2]+shift7, 2, [1,0,0]);

     }//union2
  }//diference
}//_led


module _object(){

difference(){
  _led();
    
  union(){
       //catodes
       shift=[3* ledRadius,0, -thick];
      _wire(points[0]+shift, leds[6]+shift, 1, color = [0,1,1]);
      _wire(points[1]+shift, leds[7]+shift, 1, color = [0,1,1]);
      _wire(points[2]+shift, leds[8]+shift, 1, color = [0,1,1]);
       shift2=[-ledRadius,0,-thick];
      _wire(points[3]+shift2, points[15]+shift2, 2, color = [0,0,1]);
      //anodes
       shift3=[0, -3* ledRadius, -thick];
      _wire(leds[6]+shift3, points[15]+shift3, 1, color = [0,0,1]);
      _wire(leds[3]+shift3, points[11]+shift3, 1, color = [0,0,1]);
      _wire(leds[0]+shift3, points[7]+shift3, 1, color = [0,0,1]);
       shift4=[-ledRadius,0,-thick];
      _wire(points[0]+shift4, points[3]+shift4, 2, color = [0,1,1]);
    } //union
  }// difference
} // module object

/* //test 1 square board 
intersection(){
    _object();
    translate([-square_frameW,-2*square_frameW,-thick+1])
    cube([1.7*square_frameW+frameW,2.2* square_frameW,square_frameW]);
    }
*/
_object();