/* [Global] */

//meassure distance
//translate([11,5,0])
//cube([65, 2,2]);

/* [Part select] */
part = "box";   // [box, lid, both]

/* [PCB parameters] */
// PCB length
pcbLenght = 71;
// PCB width
pcbWidth = 50;
// PCB thickness
pcbT = 2;
// PCB distance from lid
pcbL = 3;
// PCB mounting hole diameter
pcbHole = 3;
// holes's center distance from pcb's corner (X)
pcbHoleX = 2.6;
// holes's center distance from pcb's corner (Y)
pcbHoleY = 2.6;
/* [Box paramaters] */
// gap between box and pcb's left (and right) edge
gapX = 7;
// gap between box and pcb's top (and bottom) edge
gapY = 1 ;
// inner depth
depth = 75;
// wall thickness
wall = 1.5;

/* [Power connector] */
powerConn = "no";   // [yes,no]
// diameter of power connector
powerD = 14;
// center distance from PCB
power2pcb = 25.;
// center distance from bottom left corner of PCB
power2corner = 60;

/* [USB connector] */
usbConn = "yes";   // [yes,no]
// USB hole height
usbH = 15;
// USB hole width
usbW = 10;
// center line distance from PCB
usb2pcb = 25.0;
// center line distance from bottom left corner of PCB
usb2corner = 50;

/* [Sensor hole] */
sensorHole = "no";  // [yes,no]
// diameter
sensorD = 10;
// distance from bottom edge of PCB
sensorBottom = 11;
// distance from left edge of PCB
sensorLeft = 8;

/* [Lid] */
// lid bolt diameter, equal to pcbHole
lidBolt = pcbHole;
// number of bolts
lidBoltsNr = 2;           // [2,4]
// head of bolt
lidBoltHead = "socket";   // [socket, flat]

/* [Mounting] */
// box mounting bolt diameter
mountBolt = 3;
// mounting tabs on left and right sides
leftRightMounts = "yes";  // [yes,no]
// mounting taps on top and Bottom sides
topBottomMounts = "yes";   // [yes,no]

/* [Perforation] */
// Perforation at top
perforationTop = "yes";  // [yes,no]
// Perforation at sides
perforationSides = "yes";  //  [yes,no]
// diameter of ventillation holes
ventHole = 8;

/* [Hidden] */
length = pcbLenght + 2 * gapX;        // inner length
width = pcbWidth + 2 * gapY;          // inner width
mountW = 3 * mountBolt;               // mounting plate width
gridForbiddenZone = 2 * pcbHoleX;     // perforation holes distance from box inner edges
minVentHolesDist = ventHole * 2 / 3;  // ventillation holes distance
powerL1 = power2pcb + pcbT + pcbL;
usbL1 = usb2pcb + pcbT + pcbL;
$fn = 64;

module rPlate(l = length, wd = width, wa = wall, r = 0) {
  translate([r, r, 0]) minkowski() {
    cube([l - 2 * r, wd - 2 * r, wa - 0.1]);
    cylinder(h = .1, r = r);
  }
}

module mountTab(xSize, ySize, slotXSize, slotYSize, lidWall) {
  difference() {
    rPlate(xSize, ySize, lidWall, 2 * wall);
    translate([mountBolt, (ySize - slotYSize) / 2, -.1])
      cube([slotXSize, slotYSize, lidWall + 0.2]);
  }
}

module lidHole(lidWall) {
  if (lidBoltHead == "socket")
    cylinder(d = 2 * lidBolt, h = lidWall + 0.2);
  else
    cylinder(d1 = 2 * lidBolt, d2 = lidBolt, h = lidWall + 0.2);
  translate([0, 0, lidWall - 0.1])
    cylinder(d = lidBolt, h = pcbL + 0.2);
}

module lidplate(lidWall) {
  brimX = gapX + pcbHoleX;
  brimY = gapY + pcbHoleY;

  difference() {
    union() {
      rPlate(length + 2 * wall, width + 2 * wall, lidWall, wall);
      translate([wall, wall, lidWall -.1])
        difference() {
          rPlate(length, width, pcbL + .1, 0);
          translate([brimX, brimY, -.1])
            rPlate(length - 2 * brimX, width - 2 * brimY, pcbL + .3, 0);
        }
      }
    translate([wall + pcbHoleX + gapX, wall + pcbHoleY + gapY, -.1])
      lidHole(lidWall);
    translate([length + wall - pcbHoleX - gapX, width + wall - pcbHoleY - gapY, -0.1])  
      lidHole(lidWall);
    if (lidBoltsNr == 4) {
      translate([wall + pcbHoleX + gapX, width + wall - pcbHoleY - gapY, -.1])
        lidHole(lidWall);
      translate([length + wall - pcbHoleX - gapX, wall + pcbHoleY + gapY, -0.1])  
        lidHole(lidWall);
    }
  }
}

module lid() {
  xSize = 18;
  ySize = 18;
  slotXSize = mountBolt + .2;
  slotYSize = 3 * mountBolt;
  lidWall = wall >= 2 ? wall : 2;

  translate([0, 0, 0])
    lidplate(lidWall);
  if (leftRightMounts == "yes") {
    translate([- xSize + 2 * slotXSize, (width + 2 * wall - ySize) / 2, 0])
      mountTab(xSize, ySize, slotXSize, slotYSize, lidWall);
    translate([length + 2 * wall + xSize - 2 * slotXSize, (width + 2 * wall - ySize) / 2, 0])
      mirror([1, 0, 0])
        mountTab(xSize, ySize, slotXSize, slotYSize, lidWall);
  }
  if (topBottomMounts == "yes") {
    translate([length / 2 + wall + ySize / 2, -xSize + 2 * slotXSize, 0])
      rotate([0, 0, 90])
      mountTab(xSize, ySize, slotXSize, slotYSize, lidWall);
    translate([length / 2 + wall - ySize / 2, width + 2 * wall + xSize - 2 * slotXSize, 0])
      rotate([0, 0, 270])
        mountTab(xSize, ySize, slotXSize, slotYSize, lidWall);
  }
}

// rounded cube
module rCube(l = length, w = width, d = depth, r = wall) {
  hull() {
    translate([r, r, 0])
      sphere(r = r);
    translate([l - r, r, 0])
      sphere(r = r);
    translate([l - r, w - r, 0])
      sphere(r = r);
    translate([r, w - r, 0])
      sphere(r = r);
  }
  rPlate(l, w, d, r);
}

module mountingHole(outD, outH) {
  inH = depth - wall;
  translate([0, 0, 0])
    difference() {
      cylinder(d = outD+2, h = outH);
      translate([0, 0, outH - inH + 0.1])
        cylinder(d = lidBolt, h = inH);
    }
}

// rounded box
module rBox(l = length, wd = width, d = depth, wa = wall, r = wall) {
  difference() {
    rCube(l, wd, d - r, wa);
    translate([wa, wa, -.1])
      rCube(l - 2 * wa, wd - 2 * wa, d + .2);
//      rCube(l - 2 * wa, wd - 2 * wa, d + .2, 0);
  }
}
//rCube(l = length, w = width, d = depth, r = wall) 

module baseBox(length, width) {
  rBox(length + 2 * wall, width + 2 * wall, depth + wall, wall, wall);
  translate([wall + pcbHoleX + gapX, wall + pcbHoleY + gapY, -.1])
    mountingHole(2 * lidBolt, depth - pcbT - pcbL + .1);
  translate([wall + pcbHoleX + gapX, width + wall - pcbHoleY - gapY,  -.1])
    mountingHole(2 * lidBolt, depth - pcbT - pcbL + .1);
  translate([length + wall - pcbHoleX - gapX, wall + pcbHoleY + gapY, -.1])
    mountingHole(2 * lidBolt, depth - pcbT - pcbL + .1);
  translate([length + wall - pcbHoleX - gapX, width + wall - pcbHoleY - gapY, -.1])
    mountingHole(2 * lidBolt, depth - pcbT - pcbL + .1);
    //ROB
  //translate([length + wall - pcbHoleX - gapX - 2.5, width + wall - pcbHoleY - gapY +2, -.1])
    //cube([5, 4, depth - pcbT - pcbL + .1]);
  //ROBend
}

module shiftedHoles(l, wd, wa, szX, szY) {
  xSize = l - 2 * szX;
  ySize = wd - 2 * szY;
  xCount = floor(xSize / (minVentHolesDist + ventHole));
  xDist = (xSize - xCount * ventHole) / xCount;
  yCount = floor(ySize / ventHole);
  yDist = (ySize - yCount * ventHole) / (yCount - 1);
  for (j = [0: yCount - 1]) {
    shift = j % 2 == 0 ? ventHole / 2 : xDist / 2 + ventHole;
    for (i = [0: xCount - 1]) {
      translate([szX + i * (xDist + ventHole) + shift, szY + ventHole / 2 + j * (yDist + ventHole), 0])
        cylinder(d = ventHole, h = wa);
    }
  }
}

module perforatedBox(length, width) {
  difference() {
    baseBox(length,width);
    if (perforationTop == "yes")
      translate([wall, wall, -wall - .1])
        shiftedHoles(length, width, wall + 0.2, gridForbiddenZone, gridForbiddenZone);
    if (perforationSides == "yes") {
      translate([wall, wall + .1, 0]) rotate([90, 0, 0])
        shiftedHoles(length, depth, wall + .2, gridForbiddenZone, pcbL + pcbT);
      translate([wall, width + 2 * wall + .1, 0]) rotate([90, 0, 0])
        shiftedHoles(length, depth, wall + .2, gridForbiddenZone, pcbL + pcbT);
      translate([-.1, wall, 0]) rotate([90, 0, 90])
        shiftedHoles(width, depth, wall + .2, gridForbiddenZone, pcbL + pcbT);
      translate([length + wall - .1, wall, 0]) rotate([90, 0, 90])
        shiftedHoles(width, depth, wall + .2, gridForbiddenZone, pcbL + pcbT);
    }
  }
}

module box(length, width) {
  difference() {
    union () {
      if (perforationTop == "yes" || perforationSides == "yes")
        perforatedBox(length, width);
      else
        baseBox(length, width);
      if (powerConn == "yes")
        translate([power2corner + gapX + wall, wall, depth - powerL1 + wall])
          rotate([90, 0, 0])
            cylinder(d = powerD + 2 * wall, h = wall);
      if (usbConn == "yes")
        translate([usb2corner + gapX + wall, wall / 2, depth - usbL1 + wall])
          cube([usbH + 2 * wall, wall, usbW + 2 * wall], true);
      if (sensorHole == "yes")
        translate([sensorLeft + gapX + wall, sensorBottom + gapY + wall, -wall])
          cylinder(d = sensorD + 2 * wall, h = wall);
    }
    if (powerConn == "yes")
      translate([power2corner + gapX + wall, wall + .1, depth - powerL1 + wall])
        rotate([90, 0, 0])
          cylinder(d = powerD, h = wall + .2);
    if (usbConn == "yes")
      translate([usb2corner + gapX + wall, wall / 2 - .1, depth - usbL1 + wall])
        cube([usbH, wall + .3, usbW], true);
    if (sensorHole == "yes")
     translate([sensorLeft + gapX + wall, sensorBottom + gapY + wall, -wall -.1])
        cylinder(d = sensorD, h = wall + 0.2);
  }
}

print_part();

module print_part() {
  if (part == "box") {
    translate([0, 0, wall]) box(length, width);
  } else if (part == "lid") {
    lid();
  } else if (part == "both") {
    translate([0, 0, wall]) box(length, width);
    translate([0, width + 20, 0]) lid();
  } else {
    translate([0, 0, wall]) box(length, width);
    translate([0, width + 20, 0]) lid();
  }
}
