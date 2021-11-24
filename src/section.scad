include <config.scad>
use <common.scad>
use <point.scad>
use <frame.scad>

module section(width, height, grid_spacing, board_depth, line_width,
               hole_depth, hole_radius, magnet_radius, magnet_height,
               interconnect_tolerance, interconnect_margin,
               interconnect_length, board_radius, n=true, e=true, s=true, w=true) {
  real_width = grid_spacing*width;
  real_height = grid_spacing*height;
  vfin = (real_height - 4*interconnect_margin -
          2 * (magnet_radius + interconnect_tolerance)) / 2;
  vslot = vfin + 2*interconnect_tolerance;
  hfin = (real_width - 4*interconnect_margin -
          2 * (magnet_radius + interconnect_tolerance)) / 2;
  hslot = hfin + 2*interconnect_tolerance;
  fin = board_depth - 2 * interconnect_margin;
  interconnect_depth = interconnect_length + interconnect_tolerance;
  slot = fin + 2*interconnect_tolerance;
  mh_depth = magnet_height + interconnect_tolerance;
  mh_radius = magnet_radius + interconnect_tolerance;
  difference() {
    union() {
      for(x=[0:width-1]) {
        for(y=[0:height-1]) {
          translate([x*grid_spacing, y*grid_spacing, 0])
          point(bredth=grid_spacing, depth=board_depth, line_width=line_width,
                hole_depth=hole_depth, hole_radius=hole_radius,
                n=!(!n && y == height-1), e=!(!e && x == width-1),
                s=!(!s && y == 0), w=!(!w && x == 0));
        }
      }
      translate([real_width/2, real_height/2, board_depth/2])
      for(i = [0:1]) {
        rotate([0, 0, i*180]) {
          if ((i == 0 && n) || (i == 1 && s))
          translate([(real_width/2) - (hfin/2) - interconnect_margin, (real_height/2) + (interconnect_length/2), 0])
          cube(size=[hfin, interconnect_length, fin], center=true);
          if ((i == 0 && e) || (i == 1 && w))
          translate([(real_width/2) + (interconnect_length/2), -(real_height/2) + (vfin/2) + interconnect_margin, 0])
          cube(size=[interconnect_length, vfin, fin], center=true);
        }
      }
      translate([-board_radius, -board_radius, 0])
      frame([real_width, real_height, board_depth], board_radius, north=!n, east=!e, south=!s, west=!w);
    }

    translate([real_width/2, real_height/2, board_depth/2])
    rotate([-90, 0, 0])
    for(i = [0:1]) {
      rotate([0, i*180, 0]) {
        if ((i == 0 && n) || (i == 1 && s)) {
          translate([0, 0, real_height/2 - mh_depth])
          cylinder(h=mh_depth+0.001, r=mh_radius);
          translate([-(real_width/2) + (hslot/2) + interconnect_margin, 0, (real_height/2) - (interconnect_depth/2)])
          cube(size=[hslot, slot, interconnect_depth+0.001], center=true);
        }
        if ((i == 0 && e) || (i == 1 && w)) {
          rotate([0, 90, 0])
          translate([0, 0, real_width/2 - mh_depth])
          cylinder(h=mh_depth+0.001, r=mh_radius);
          translate([(real_width/2) - (interconnect_depth/2), 0, (real_height/2) - (vslot/2) - interconnect_margin])
          cube(size=[interconnect_depth+0.001, slot, vslot], center=true);
        }
      }
    }
  }

}

section(width=3, height=3, grid_spacing=grid_spacing_x, board_depth=board_depth,
        line_width=line_thickness, hole_depth=peg_h,
        hole_radius=peg_r+hole_tolerance, magnet_radius=5, magnet_height=4,
        interconnect_tolerance=0.25, interconnect_margin=5, interconnect_length=6, board_radius=5, e=false, s=false);
