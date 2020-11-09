# accessible-go

Models for an accessible go set.

## Model Files

The `src` directory contains the Scad files for the models.

`goban.scad`
: The goban (board).
`ishi_black.scad` and `ishi_white.scad`
: The ishi (stones). Which one you choose to use for black and white doesn't 
  matter, as long as you are consistent. 

Currently, there are parameters that need to be changed across all files in 
order for the set to work properly.

## Usage

The `*.scad` files are intended for use with OpenSCAD. You should be able to
open them, change any parameters, export and print. I have not yet been able to
test how well the models work in the real world.