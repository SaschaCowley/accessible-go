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