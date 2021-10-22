use <MCAD/shapes/2Dshapes.scad>
use <MCAD/shapes/3Dshapes.scad>
include <MCAD/units/metric.scad>

$fs = 0.4;
$fa = 1;

pin_length_above_stopper = 23;


module round_2d(r)
{
    offset(-r)
    offset(r)
    children();
}

module pin_shape()
{
    crown_height = 4.5;

    /* base shape */
    translate([0, 0, -crown_height])
    mirror(Z)
    ccube([8, 4, 20], center=Y);

    /* crown */
    translate([0, 0, -(crown_height + epsilon)])
    intersection() {
        rotate(90, X)
        linear_extrude(4, center=true)
        translate([8/2, 0])
        trapezoid(bottom=8, top=7, height=crown_height, left_angle=90);

        rotate(90, Y)
        rotate(90, Z)
        linear_extrude(8)
        trapezoid(bottom=4, top=2.2, height=crown_height);
    }
}

module stopper()
{
    difference() {
        linear_extrude(8.4)
        difference() {
            round_2d(2)
            union() {
                csquare([6, 5], center=Y);

                translate([7.3, 0])
                circle(d=10);
            }

            translate([7.3, 0])
            circle(d=5);
        }

        translate([1.89, 0, 2.72])
        rotate(90, X)
        mcad_rounded_cube([20, 20, 20], radius=5, sidesonly=true, center=Z);
    }
}


rotate(-90, Y)
translate([0, 0, pin_length_above_stopper])
pin_shape();

stopper();
