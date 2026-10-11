include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

HOSHI = [
	[3, [
		[1, 1]
	]],
	[9, [
		[1, 1], 	[7, 1],
			[4, 4],
		[7, 1], 	[7, 7]
	]],
	[13, [
		[2, 2], 	[10, 2],
			[6, 6],
		[2, 10], 	[10, 10]
	]],
	[19, [
		[3, 3], [9, 3], [15, 3],
		[3, 9], [9, 9], [15, 9],
		[3, 15], [9, 15], [15, 15]
	]]
];

SCREWS = [
	[3, [
		[0, 0], [2, 0],
		[0, 2], [2, 2]
	]],
	[9, [
		[0, 0], [4, 0], [8, 0],
		[0, 4], 	[8, 4],
		[0, 8], [4, 8], [8, 8]
	]],
	[13, [
		[0, 0], [6, 0], [12, 0],
		[0, 6], 	[12, 6],
		[0, 12], [6, 12], [12, 12]
	]],
	[19, [
		[0, 0], [9, 0], [18, 0],
		[0, 9], [18, 9],
		[0, 18], [9, 18], [18, 18]
	]]
];

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