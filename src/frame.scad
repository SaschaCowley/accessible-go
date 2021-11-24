use <MCAD/boxes.scad>
use <point.scad>

module frame(size, radius, north=true, east=true, south=true, west=true) {
  rsize = size+[2*radius, 2*radius, 0];
  difference() {
    translate(rsize/2)
    roundedBox(rsize, radius, false);
    union() {
      translate([radius, radius, -0.001])
      cube(size+[0, 0, 0.002]);
      if (!north)
      translate([-0.001, size.y+radius-0.001, -0.001])
      cube(size=[rsize.x+0.002, radius+0.002, rsize.z+0.002]);
      if (!east)
      translate([size.x+radius-0.001, -0.001, -0.001])
      cube(size=[radius+0.002, rsize.y+0.002, rsize.z+0.002]);
      if (!south)
      translate([-0.001, -0.001, -0.001])
      cube(size=[rsize.x+0.002, radius+0.002, rsize.z+0.002]);
      if (!west)
      translate([-0.001, -0.001, -0.001])
      cube(size=[radius+0.002, rsize.y+0.002, rsize.z+0.002]);
    }
  }
}

frame([75, 75, 15], 5, north=false, east=false);
