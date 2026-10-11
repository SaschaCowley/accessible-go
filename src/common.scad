include <config.scad>
use <MCAD/boxes.scad>

function board_dim(num_lines, line_thickness, spacing, margin) = 
  (num_lines * (line_thickness + spacing)) + (2 * margin) - spacing;

module grid(x, y, spacing_x, spacing_y, line) {
  width = ((x - 1) * spacing_x) + (x * line);
  height = ((y - 1) * spacing_y) + (y * line);
  for(i = [0:x-1]) {
    translate([(-width / 2) + (i * (spacing_x + line)) + line/2, 0, 0])
    rotate([90, 0, 0])
    cylinder(h=height, r=line/2, center=true);
  }
  for(i = [0:y-1]) {
    translate([0, (-height / 2) + (i * (spacing_y + line)) + line/2, 0])
    rotate([0, 90, 0])
    cylinder(h=width, r=line/2, center=true);
  }
}

module ishi(stone_rxy, stone_rz, peg_r, peg_h, bump_rxy, bump_rz) {
  union() {
    resize([stone_rxy*2, stone_rxy*2, stone_rz*2])
    sphere(r=stone_rxy);

    hull() {
      translate([0, 0, -(peg_h + stone_rz)/2])
      cylinder(h=peg_h + stone_rz, r=peg_r, center=true);

      translate([0, 0, stone_rz])
      resize([2*bump_rxy, 2*bump_rxy, 2*bump_rz])
      sphere(r=bump_rxy);
    }
  }
}

module board(x=grid_x, y=grid_y) {
  difference() {
    union() {
      roundedBox([board_dim(x, line_thickness, grid_spacing_x, margin_x), board_dim(y, line_thickness, grid_spacing_y, margin_y), board_depth], board_r);
      translate([0, 0, board_depth / 2])
      scale([1, 1, 2])
      grid(x, y, grid_spacing_x, grid_spacing_y, line_thickness);
    }
    
    width = ((x - 1) * grid_spacing_x) + (x * line_thickness);
    height = ((y - 1) * grid_spacing_y) + (y * line_thickness);
    for(i = [0:x-1]) {
      for(j = [0:y-1]) {
        translate([(-width / 2) + (i * (grid_spacing_x + line_thickness)) + line_thickness/2, (-height / 2) + (j * (grid_spacing_y + line_thickness)) + line_thickness/2, ((board_depth / 2) + line_thickness) - (peg_h / 2) + 0.001])
        cylinder(h=peg_h, r=peg_r + hole_tolerance, center=true);
      }
    } 
  }
}