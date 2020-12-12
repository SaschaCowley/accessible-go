use <MCAD/boxes.scad>
use <common.scad>
include <config.scad>

difference() {
  union() {
    roundedBox([((grid_x - 1) * grid_spacing_x) + (grid_x * line_thickness) + (2 * margin_x), ((grid_y - 1) * grid_spacing_y) + (grid_y * line_thickness) + (2 * margin_y), board_depth], board_r);
    translate([0, 0, board_depth / 2])
    scale([1, 1, 2])
    grid(grid_x, grid_y, grid_spacing_x, grid_spacing_y, line_thickness);
  }
  
  width = ((grid_x - 1) * grid_spacing_x) + (grid_x * line_thickness);
  height = ((grid_y - 1) * grid_spacing_y) + (grid_y * line_thickness);
  for(i = [0:grid_x-1]) {
    for(j = [0:grid_y-1]) {
      translate([(-width / 2) + (i * (grid_spacing_x + line_thickness)) + line_thickness/2, (-height / 2) + (j * (grid_spacing_y + line_thickness)) + line_thickness/2, ((board_depth / 2) + line_thickness) - (peg_h / 2) + 0.001])
      cylinder(h=peg_h, r=peg_r + hole_tolerance, center=true);
    }
  } 
}