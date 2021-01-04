//Sink Diameter
SinkDiameter=50;
//Deepth
SinkDepth=16;
//Border width
BorderWidth=15;
//Thikness
Thikness=1.5;
//Diameter of the holes
HoleDiameter=3;

/* [Hidden] */
//DA=60;
SkR=SinkDiameter/2;
SR=(pow(SkR,2)+pow(SinkDepth,2))/(2*SinkDepth);
echo(SR);
DA=atan(SkR/(SR-SinkDepth));
echo(DA);
//SR=SinkDiameter/(2*sin(DA));
HR=HoleDiameter/2;
HH=SR+Thikness;
PeH=HR*cos(36)/(2*sin(36));
HeH=HR*cos(30);
FD=SinkDiameter+2*BorderWidth;

ArcLenght=SR*PI*DA/180;
Layers=floor((ArcLenght-PeH)/(2*HeH+Thikness));
Rings=floor((BorderWidth-2*Thikness)/(2*HeH+Thikness));


$fa=2;
$fs=1;


translate([0,0,-SR*cos(DA)+Thikness])
difference(){
	union(){
	translate([0,0,+SR*cos(DA)-Thikness])
		difference(){
			cylinder(d1=FD-4*Thikness,h=Thikness,d2=FD);
			for (k=[0:4])
				rotate([0,0,k*72])
					for (j=[1:Rings])
						for (i=[0:Layers])
							rotate([0,0,(i+(j-1)/2)*72/(Layers+1)])
								translate([0,-SkR-(j-1)*(2*HeH+Thikness)-HeH-Thikness,0])
									rotate([0,0,-j*30])
										cylinder(r=HR,h=3*Thikness,center=true,$fn=6);}
	difference(){
		sphere(r=SR);
		union(){
			rotate([0,0,18]){		
				cylinder(r=HR/(2*sin(36)),h=HH,$fn=5);}
			for (k=[0:4])
				rotate([0,0,k*72])
				for (i=[0:Layers]){
					LayerArc=72/(i+1);
					for (j=[0:i]){
						SkRr=(j!=0)? HeH*sin(36):0;
						rotate([((((i+1)*(2*HeH+Thikness)+PeH-HeH-SkRr))/SR)*180/PI,0,j*LayerArc])
							rotate([0,0,-j*60/(i+1)])							
								cylinder(r=HR,h=HH,$fn=6);
					}
				}
			
		}
	}
}
	sphere(r=SR-Thikness);
	translate([0,0,-SR*(1-cos(DA))-Thikness])
		cube(2*SR,center=true);
}


//			for (k=[0:4])
//				rotate([0,0,k*72])
//					for (j=[1:Rings])
//						for (i=[0:Layers+j])
//							rotate([0,0,i*72/(Layers+j+1)])
//								translate([0,-SR-j*(2*HeH+Thikness)+RBL,0])
//									rotate([0,0,-i*60/(Layers+j+1)])
//										cylinder(r=HR,h=3*Thikness,center=true,$fn=6);}
