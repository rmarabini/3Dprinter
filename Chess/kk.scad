mode = 0;

module part1() {
     cube(20, center = true);
}

module part2() {
     cylinder(r = 5, h = 21, center = true);
}

module assembly() {
     difference() {
         part1();
         part2();
     }
}

if (mode == 1) {
     part1();
} else if (mode == 2) {
     part2();
} else {
     assembly();
}
