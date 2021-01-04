$fn=100;
h=15.0;
r1 = 8;
r2 = 5;
w = 3;


module chamfercyl(
   r,              // cylinder radius
   h,              // cylinder height
   b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
   t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
   offset=[[0,0]], // optional offsets in X and Y to create
                   // convex hulls at slice level
   slices=10,      // number of slices used for chamfering
   eps=0.01,       // tiny overlap of slices
){
    astep=90/slices;
    hull()for(o = offset)
       translate([o[0],o[1],abs(b)-eps])cylinder(r=r,h=h-abs(b)-abs(t)+2*eps);
    if(b)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],abs(b)-abs(b)*sin(a+astep)-eps])
          cylinder(r2=r+(1-cos(a))*b,r1=r+(1-cos(a+astep))*b,h=(sin(a+astep)-sin(a))*abs(b)+2*eps);
    if(t)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],h-abs(t)+abs(t)*sin(a)-eps])
          cylinder(r1=r+(1-cos(a))*t,r2=r+(1-cos(a+astep))*t,h=(sin(a+astep)-sin(a))*abs(t)+2*eps);
}

module draw(){

difference(){

  union(){    
    cylinder(h=h, r1=r1, r2=r2);
    translate([0, 0, 2*h])
       {
         rotate(a=[0,180,0])
         cylinder(h=h, r1=r1, r2=r2);
       }
    }  

union(){  
    translate([0, 0, -1])  
    cylinder(h=h*1.1, r1=r1-w, r2=r2-w);
   
    translate([0, 0, 2*h+1])
    {
        rotate(a=[0,180,0])
        cylinder(h=h*1.1, r1=r1-w, r2=r2-w);
    }

    translate([r2, 0, h + r2])
    {
        rotate(a=[0,180,0])
        chamfercyl(h=r2*2, r=r2-w, t=-2, b=-2);
    }
    translate([r2-3, 0, h + r2])
    {
        rotate(a=[0,180,0])
        chamfercyl(h=r2*2, r=r2-w, t=-2, b=-2);
    }

  }
}
}

 draw();