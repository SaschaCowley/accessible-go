use <goban.scad>
use <common.scad>
include <config.scad>

module corner() {
  union() {
    difference() {
      /* Isolate the bottom left corner of the goban. */
      intersection() {
        translate([-bx/3, -by/3, line_thickness/2])
        cube([bx/3, by/3, bz], center=true);
        board(9, 9);
      }
      
      /* Right top slot. */
      translate([-(bx/6) - fin_length - interconnect_tolerance,
                 (-by/6) - hfin - fin_margin + interconnect_tolerance,
                 -(fin_thickness / 2) - interconnect_tolerance])
      cube([fin_length + interconnect_tolerance + 0.001,
            vfin+(2 * interconnect_tolerance),
            fin_thickness + (2 * interconnect_tolerance)]);
      
      /* Top left slot. */
      translate([-(bx/2) + fin_margin - interconnect_tolerance,
                 -(by/6) - fin_length - interconnect_tolerance,
                 -(fin_thickness/2) - interconnect_tolerance])
      cube([hfin + (2 * interconnect_tolerance), 
            fin_length + interconnect_tolerance + 0.001,
            fin_thickness + (2 * interconnect_tolerance)]);
      
      /* Right hole. */
      translate([-(bx/6) - (mag_h / 2), -by/3, 0])
      rotate([0, 90, 0])
      cylinder(h=mag_h + 0.001, r=mag_r + interconnect_tolerance, center=true);
      
      /* Top hole. */
      translate([-bx/3, -(by/6) - (mag_h / 2), 0])
      rotate([90, 0, 0])
      cylinder(h=mag_h + 0.001, r=mag_r + interconnect_tolerance, center=true);
    }
    
    /* Right bottom fin. */
    translate([-bx/6, (-by/2) + fin_margin, -(fin_thickness/2)])
    cube([fin_length, vfin, fin_thickness]);
    
    /* Top right fin. */
    translate([(-bx/6) - hfin - fin_margin, -by/6, -(fin_thickness/2)])
    cube([hfin, fin_length, fin_thickness]);
  }
}

corner();