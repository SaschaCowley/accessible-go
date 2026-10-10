include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

function ishi_bottom_d(mag_od, wall, clearance) = mag_od + clearance + 2*wall;
function ishi_bottom_h(mag_h, wall, clearance) = mag_height + clearance + wall;

module ishi_bottom(mag_od, mag_id, mag_h, bump_d, bump_h, wall, clearance_mag, clearance_bump, eps) {
	difference() {
		// Outer shell
		cyl(
			h=ishi_bottom_h(mag_h, wall, clearance_mag),
			d = ishi_bottom_d(mag_od, wall, clearance_mag),
			align = V_UP,
		);
		
		// Magnet
		up(wall)
		tube(
			h = mag_h + clearance_mag + eps,
			od = mag_od + clearance_mag,
			id = mag_id - clearance_mag,
			align = V_UP,
		);
		
		// Divot
		down(eps)
		cyl(
			h = bump_h + clearance_bump + eps,
			d = bump_d + clearance_bump,
			fillet2 = bump_h / 2,
			align = V_UP,
		);
		fillet_hole_mask(
			d = bump_d + clearance_bump,
			fillet = bump_h / 2,
			overage = eps,
		);
	}
}

function ishi_top(d, h, bottom_d, bottom_h, bump_d, bump_h, wall, clearance, eps) {
	top_h = h - bottom_h;
	bottom_r = (d - bottom_d - clearance) / 2 - wall;
	
	union() {
		// Bottom half
		difference() {
			tube(
				h = bottom_h+eps,
				od = d,
				id = bottom_d + clearance,
				align = V_UP,
			);
			fillet_cylinder_mask(
				d = d,
				fillet = bottom_r,
			);
		}
	
		// Top half
		up(bottom_h)
		hull() {
			// Dome
			top_half(s = 2*top_h + eps)
			resize([0, 0, 2*top_h])
			sphere(d=d);
			// Bump
			up(top_h)
			resize([0, 0, bump_h])
			sphere(d=bump_d);
		}
	}
}