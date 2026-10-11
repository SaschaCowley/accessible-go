include<geometry.scad>
use <grid.scad>

/* [Tolerances] */
// Wall thickness
WALL = 1.0;

// Snug fit clearance
CLEARANCE_SNUG = 0.2;

// Loose fit clearance
CLEARANCE_LOOSE = 0.5;

/* [Magnets] */
// Outer diameter
MAG_OD = 17.5;

// Inner diameter
MAG_ID = 5.0;

// Thickness
MAG_H = 3.0;

/* [Bolts] */
// Screw shank diameter
SCREW_SIZE = 4.0;

// Screw head height
SCREW_HH = 2.48;

// Screw head diameter
SCREW_HD = 8.96;

// Diameter of blind hole for thread forming screw
BLIND_D = 1.8;

// Depth of hole for thread forming screw
BLIND_H = 12.0;

/* [Board] */
// Size of grid (number of rows and columns)
GRID_SIZE = 3; // [3, 9, 13, 19]
SPACING_X = 25.0;
SPACING_Y = 25.0;
LINE_R = 1.0;

/* [Stones] */
// Diameter
ISHI_D = 22.0;

// Height
ISHI_H = 7.0;

// Bump width
ISHI_BD = 2.0;

// Bump height
ISHI_BH = 1.5;

/* [Hidden] */
EPS = 0.01;
hoshi=[[1, 1]];
screws=[[0,0],[2,0],[0,2],[2,2]];


grid(
	grid_x=GRID_SIZE,
	grid_y=GRID_SIZE,
	spacing_x=SPACING_X,
	spacing_y=SPACING_Y,
	line_r=LINE_R,
	screw_size=SCREW_SIZE,
	screw_hh=SCREW_HH,
	screw_hd=SCREW_HD,
	blind_id=BLIND_D,
	blind_od=MAG_ID-CLEARANCE_SNUG,
	blind_h=BLIND_H,
	hoshi=hoshi(GRID_SIZE),
	screws=screws(GRID_SIZE),
	eps=EPS
);
