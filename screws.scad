//
//Module fordDrawing screws
//

//Example os use
//uncomment next line
screw(m=3, h=8, $fn=100);
//
//1st parameter: screw metric diameter
//2nd parameter: screw hight
//3rd parameter: cylinders definition


//array with the data for standard screws
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

module screw(m=3, l=8, $fn=20) {

  for (iScrew=dScrew) {
    if (iScrew[0] == m) {
      //head diameter
      hd=iScrew[1];
      //allen size
      as=iScrew[2];
      //allen depth
      ad=iScrew[3];
      //step
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
