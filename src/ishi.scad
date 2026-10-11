include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

assert(MAG_OD + CLEARANCE_LOOSE + 4 * WALL <= ISHI_D);
d1 = MAG_ID - CLEARANCE_LOOSE;
d2 = MAG_OD + CLEARANCE_LOOSE;
d3 = d2 + 2*WALL;
base_h = MAG_H + WALL + CLEARANCE_LOOSE;
cap_h = ISHI_H - base_h;



module ishi_top(ring_id, ring_od, ring_h, cap_d, cap_h, bump_d, bump_h, eps) {
	union() {
		tube(id=ring_id, od=ring_od, h=ring_h+eps, align=V_ABOVE);
		up(ring_h) {
			top_half()
			resize([0, 0, 2*cap_h])
			sphere(d=cap_d);
			cyl(d=bump_d, h=cap_h, align=V_ABOVE);
			up(cap_h)
			resize([0, 0, 2*bump_h])
			sphere(d=bump_d);
		}
	}
}

module ishi_bottom(base_h, base_d, cutout_id, cutout_od, divot_h, divot_d, wall, eps) {
	difference() {
		cyl(d=base_d, h=base_h, fillet1=wall, align=V_ABOVE);
		up(wall)
		tube(id=cutout_id, od=cutout_od, h=base_h - wall + eps, align=V_ABOVE);
		down(eps)
		cyl(d=divot_d, h=divot_h+eps, fillet2=divot_h/2, align=V_ABOVE);
		fillet_hole_mask(d=divot_d, fillet = divot_h/2, overage=eps);
	}
}

up(base_h+1)
ishi_top(ring_id=d2, ring_od=d3, ring_h=MAG_H, cap_d=ISHI_D, cap_h=cap_h, bump_d=ISHI_BD, bump_h=ISHI_BH, eps=EPS);
ishi_bottom(base_h=base_h, base_d=ISHI_D, cutout_id=d1, cutout_od=d3, wall=WALL, eps=EPS, divot_h=ISHI_BH+CLEARANCE_LOOSE, divot_d=ISHI_BD+CLEARANCE_LOOSE);