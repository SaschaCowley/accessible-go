$fa = 1;
$fs = 0.4;

stone_r = 11;
stone_h = 9;
peg_r = 3.5;
peg_h = 15;
bump_r = 0;
bump_h = 0;

union() {
  resize([stone_r*2, stone_r*2, stone_h])
  sphere(r=stone_r);

  translate([0, 0, -(peg_h + stone_h/2)/2])
  cylinder(h=peg_h + stone_h/2, r=peg_r, center=true);

  translate([0, 0, stone_h/2])
  resize([2*bump_r, 2*bump_r, 2*bump_h])
  sphere(r=bump_r);
}