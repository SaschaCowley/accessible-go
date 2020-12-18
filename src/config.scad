use <common.scad>

$fa = 1;
$fs = 0.4;

board_depth = 15;
board_r = 5;
grid_x = 9;
grid_y = 9;
grid_spacing_x = 25;
grid_spacing_y = 25;
line_thickness = 1.5;
margin_x = 12.5;
margin_y = 12.5;
peg_h = 13.5;
peg_r = 3.5;
hole_tolerance = 0.5;

stone_r = 11;
stone_h = 4.5;
bump_r = 2;
bump_h = 1.5;

fin_length = 6;
fin_thickness = 3;
fin_margin = 6;
mag_r = 5;
mag_h = 4;
interconnect_tolerance = 0.25;

bx = board_dim(grid_x, line_thickness, grid_spacing_x, margin_x);
by = board_dim(grid_y, line_thickness, grid_spacing_y, margin_y);
bz = board_depth+line_thickness;

hfin = ((bx / 3) - (4 * fin_margin) - (2 * mag_r)) / 2;
vfin = ((by / 3) - (4 * fin_margin) - (2 * mag_r)) / 2;