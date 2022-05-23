#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

use lib $?FILE.IO.parent(1).add("lib");
use SVGize;

=begin comment
Task 1: Scalable Vector Graphics (SVG)
Submitted by: Ryan J Thompson

Scalable Vector Graphics  are not made of pixels, but lines, ellipses,
and curves, that can be scaled to any size without any loss of quality.
SVG files are simply XML files;

The task is to accept a series of points and lines in the following format,
one per line, in arbitrary order:

53,10
53,10,23,30
23,30

Then generate an SVG file plotting all points, and all lines. You can view
the output .svg file in your browser.
=end comment

my $test = "
53,10
53,10,23,30
23,30";

say SVGize( _munge( _get-input( $test )));

sub _munge( @a is copy --> Array ) {
    +« [ @a.map( { [.split(',') ]} ) ];
}

sub _get-input ( Str $in --> Array ) { 
    [ grep { $_ !~~ /^\s*$/ }, $in.lines ];
}

exit;
