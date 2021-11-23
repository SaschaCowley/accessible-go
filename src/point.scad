use <common.scad>
include <config.scad>

function count(a, b) = a || b ? a && b ? 2 : 1 : 0;

module point(bredth, depth, line_width, hole_depth, hole_radius,
             n=true, e=true, s=true, w=true) {
  /* Single point for composition into larger pieces.
   *
   * The produced point will have dimensions [bredth, bredth, depth+line_width],
   * and will continue in the positive direction from the origin along all axes.
   *
   * Parameters:
   * bredth: The width/height of the point (i.e., distance between lines).
   * depth: Depth of the point (i.e., thickness of the board).
   * line_width: Thickness of the lines. Lines will have a footprint this wide,
   *             and will also be raised this far from the rest of the board.
   * hole_depth: How deep the holes for the ishi should be, measured from the
   *             top of the lines.
   * hole_radius: Radius of the holes for the ishi. Should include any
   *              necessary tolerance.
   * n, e, s, w: Whether or not to produce the northern, eastern, western and
   *             southern lines, respectively. Default true.
   */
  difference() {
    union() {
      // Base of the point.
      cube(size=[bredth, bredth, depth]);

      // Horizontal (east-west) line.
      translate([e && !w ? bredth/2 : 0, bredth/2, depth])
      scale([1, 1, 2])
      rotate([0, 90, 0])
      cylinder(h=count(e, w)*bredth/2, d=line_width);

      // Vertical (north-south) line.
      translate([bredth/2, n && !s ? bredth/2 : 0, depth])
      scale([1, 1, 2])
      rotate([-90, 0, 0])
      cylinder(h=count(n, s)*bredth/2, d=line_width);
    }
    // Stone hole.
    translate([bredth/2, bredth/2, depth + line_width - hole_depth])
    cylinder(h=hole_depth, r=hole_radius);
  }
}

point(bredth=grid_spacing, depth=board_depth, line_width=line_width,
             hole_depth=peg_h, hole_radius=peg_r+hole_tolerance);
