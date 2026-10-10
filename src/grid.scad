include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

module grid(grid_x, grid_y, spacing_x, spacing_y, r, screw_size, screw_hd, screw_hh, eps) {
	l = grid_y * spacing_y;
	w = grid_x * spacing_x;
	difference() {
		union() {
			// Horizontal gridlines
			yspread(spacing = spacing_y, n=grid_y)
			xcyl(
				l = spacing_x * grid_x,
				r = r,
				align=V_RIGHT,
			);
			// Vertical gridlines
			xspread(spacing=spacing_x, n=grid_x)
			ycyl(
				l = spacing_y * grid_y,
				r = r,
				align=V_BACK,
			);
			// Points
			grid2d(size=[grid_x, grid_y], spacing=[spacing_x, spacing_y], cols=grid_x, rows=grid_y)
			cyl(
				h = 2*r,
				d = screw_hd + 2*r,
				fillet = r,
			);
		}
		// Countersinks
		place_copies([[0,0,0], [w,0,0], [0,l,0], [w,l,0]])
		up(r + eps)
		cyl(
			h = screw_hh,
			d1 = screw_size,
			d2 = screw_hd,
			align = V_BOTTOM,
		);
	}
}