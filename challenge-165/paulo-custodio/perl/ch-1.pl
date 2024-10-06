#!/usr/bin/env perl

# Challenge 165
#
# Task 1: Scalable Vector Graphics (SVG)
# Submitted by: Ryan J Thompson
#
# Scalable Vector Graphics (SVG) are not made of pixels, but lines, ellipses,
# and curves, that can be scaled to any size without any loss of quality. If you
# have ever tried to resize a small JPG or PNG, you know what I mean by "loss of
# quality"! What many people do not know about SVG files is, they are simply XML
# files, so they can easily be generated programmatically.
#
# For this task, you may use external library, such as Perl's SVG library,
# maintained in recent years by our very own Mohammad S Anwar. You can instead
# generate the XML yourself; it's actually quite simple. The source for the
# example image for Task #2 might be instructive.
#
# Your task is to accept a series of points and lines in the following format,
# one per line, in arbitrary order:
#
# Point: x,y
#
# Line: x1,y1,x2,y2
# Example:
#
# 53,10
# 53,10,23,30
# 23,30
#
# Then, generate an SVG file plotting all points, and all lines. If done
# correctly, you can view the output .svg file in your browser.

use Modern::Perl;

sub svg_header {
    my($width,$height)=@_;
    return <<END;
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="$height" width="$width" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
END
}

sub svg_footer {
    return <<'END';
</svg>
END
}

sub svg_circle {
    my($cx, $cy, $r)=@_;
    return <<END;
<circle cx="$cx" cy="$cy" r="$r" stroke="black" />
END
}

sub svg_point {
    my($cx, $cy)=@_;
    return svg_circle($cx,$cy,1);
}

sub svg_line {
    my($x1,$y1,$x2,$y2)=@_;
    return <<END;
<line x1="$x1" y1="$y1" x2="$x2" y2="$y2" stroke="black" />
END
}

my $file=shift or die "usage: ch-1.pl file.svg\n";
open(my $f, ">", $file) or die "open $file: $!";
print $f svg_header(100,100);
while (<>) {
    chomp;
    my @p=split /\s*,\s*/,$_;
    if (@p==2) {
        print $f svg_point(@p);
    }
    elsif (@p==4) {
        print $f svg_line(@p);
    }
    else {
        die "cannot parse: $_";
    }
}
print $f svg_footer();
