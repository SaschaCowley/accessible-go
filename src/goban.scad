use <MCAD/boxes.scad>
$fa = 1;
$fs = 0.4;

board_depth = 20;
board_r = 3;
grid_x = 9;
grid_y = 9;
grid_spacing_x = 25;
grid_spacing_y = 25;
line_thickness = 1.5;
margin_x = 10;
margin_y = 10;
peg_h = 16;
peg_r = 4;

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
      cylinder(h=peg_h, r=peg_r, center=true);
    }
  } 
}