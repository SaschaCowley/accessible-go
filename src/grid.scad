include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

module grid(grid_x, grid_y, spacing_x, spacing_y, line_r, screw_size, screw_hh, screw_hd, blind_id, blind_od, blind_h, hoshi, screws, eps) {
	w = (grid_x-1)*spacing_x;
	h = (grid_y-1)*spacing_y;
	difference(){
		union() {
			top_half() {
				// Horizontal gridlines
				yspread(spacing=spacing_y, n=grid_y)
				xcyl(l=w, r=line_r);
				// Vertical gridlines
				xspread(spacing=spacing_x, n=grid_x)
				ycyl(l=h, r=line_r);
				// Intersections
				grid2d(spacing=[spacing_x, spacing_y], cols=grid_x, rows=grid_y)
				cyl(h=line_r*2, fillet=line_r, d=screw_hd + 2*line_r);
			}
			// Blind holes for upward-facing fasteners
			place_copies([for (c = screws) [c[0]*spacing_x - w/2, c[1]*spacing_y - h/2, eps]])
			tube(od=blind_od, id=blind_id, h=blind_h+eps, align=V_BELOW);
		}
		// Countersunk holes for downward facing fasteners at the star points
		up(line_r+eps)
		place_copies([for (c = hoshi) [c[0]*spacing_x - w/2, c[1]*spacing_y - h/2]])
		cyl(d1=screw_size, d2=screw_hd, h=screw_hh, align=V_BELOW);
	}
}