//
//Module fordDrawing screws
//

//Example of use
//uncomment next line for screw example
//screw(m=3, h=8, $fn=100);
//uncomment next line for nut example
//nut(m=3);
//
//1st parameter: screw metric diameter
//2nd parameter: screw hight
//3rd parameter: cylinders definition

//
//array with the data for standard screws
//
dScrew = [
  [1.6, 3, 1.5, 0.7, 0.35],
  [2, 3.8, 1.5, 1, 0.4],
  [2.5, 4.5, 2, 1.1, 0.45],
  [3, 5.5, 2.5, 1.3, 0.4],
  [4, 7, 3, 2, 0.7],
  [5, 8.5, 4, 2.5, 0.8],
  [6, 10, 5, 3, 1],
  [8, 13, 6, 4, 1.25],
  [10, 16, 8, 5, 1.5],
  [12, 18, 10, 6, 1.75],
  [14, 21, 12, 7, 2],
  [16, 24, 14, 8, 2],
  [18, 27, 14, 9, 2.5],
  [20, 30, 17, 10, 2.5],
  [22, 33, 17, 11, 2.5],
  [24, 36, 19, 12, 3],
  [27, 40, 19, 14, 3],
  [30, 45, 22, 15.5, 3.5],
  [33, 50, 24, 17, 3.5],
  [36, 54, 27, 19, 4],
  [39, 58, 27, 22, 4],
  [42, 63, 32, 24, 4.5],
  [48, 72, 36, 28, 5],
];

//
//array with the data for standard nuts
//
dNut=[
  [2, 1.6, 4, 0.4],
  [3, 2.4, 5.5, 0.5],
  [4, 3.2, 7, 0.7],
  [5, 4, 8, 0.8],
  [6, 5, 10, 1],
  [7, 5.5, 11,1],
  [8, 6.5, 13, 1.25],
  [10, 8, 17, 1.5],
  [12, 10, 19, 1.75],
  [14, 11, 22, 2],
  [16, 13, 24, 2],
  [18, 15, 27, 2.5],
  [20, 16, 30, 2.5],
  [22, 18, 32, 2.5],
  [24, 19, 36, 3],
  [27, 22, 41, 3],
  [30, 24, 46, 3.5],
  [33, 26, 50, 3.5],
  [36, 29, 55, 4],
  [39, 31, 60, 4],
  [42, 34, 65, 4.5],
  [45, 36, 70, 4.5],
  [48, 38, 75, 5],
  [52, 42, 80, 5],
  [56, 45, 85, 5.5],
  [60, 48, 90, 5.5],
  [64, 51, 95, 6],
  [68, 54, 100, 6],
];


//
//Modules
//

module screw(m=3, l=8, $fn=20) {
  //select the correct dimensions
  for (iScrew=dScrew) {
    if (iScrew[0] == m) {
      //head diameter
      hd=iScrew[1];
      //allen size
      as=iScrew[2];
      //allen depth
      ad=iScrew[3];
      //pitch
      p=iScrew[4];
      //allen radius
      ar=as/sqrt(3);

      difference() {
        union() {
          //draw the body of the screw
          cylinder(d=m, h=l, center=false, $fn=$fn);
          //draw the head of the screw
          translate([0, 0, l]) {
            cylinder(d=hd, h=m, center=false, $fn=$fn);
          }
        }
        //allen hole
        translate([0, 0, (l+m)-ad]) {
          cylinder(d=ar*2, h=ad+1, $fn=6);
        }
      }
    }
  }
}

module nut(m=3, $fn=20) {
  //select the correct dimensions
  for (iNut=dNut) {
    if (iNut[0] == m) {
      //nut height
      nh=iNut[1];
      //nut size
      ns=iNut[2];
      //pitch
      p=iNut[3];

      //nut radius
      nr=ns/sqrt(3);

      difference() {
        //drawing the basic mut
        cylinder(d=nr*2, h=nh, $fn=6);
        //drawing the hole
        translate([0, 0, -1]) {
          cylinder(d=3, h=nh+2, $fn=$fn);
        }
      }
    }
  }
}
