$fn=30;
h=2.54;
offset =3;
r=3;

union()
{
    translate([-2.14,-2.16,0])
    import("Corner.stl");
    cube([20,20,10]);

}
/*
hull(){
    translate([-40+offset,-40+offset,h/2])
    cylinder(r=r,h=h,center=true);
    translate([40-offset,40-offset,h/2])
    cylinder(r=r,h=h,center=true);
    }

hull(){
    translate([-40+offset,0+offset,h/2])
    cylinder(r=r,h=h,center=true);
    translate([0-offset,40-offset,h/2])
    cylinder(r=r,h=h,center=true);
    }
    
hull(){
    translate([0+offset,-40+offset,h/2])
    cylinder(r=r,h=h,center=true);
    translate([40-offset,0-offset,h/2])
    cylinder(r=r,h=h,center=true);
    }
    */