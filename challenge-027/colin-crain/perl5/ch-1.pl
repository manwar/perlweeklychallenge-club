#! /opt/local/bin/perl
#
#       intersection.pl
#
#       task: Write a script to find the intersection of two straight
#           lines. The co-ordinates of the two lines should be provided
#           as command line parameter. For example:
#               The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
#               The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
#           The script should print the co-ordinates of point of intersection of the above two lines.
#
#       usage: ./intersection.pl '(1,1)' '(6,6)' '(0,6)' '(6,0)'
#
#       V3
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use Getopt::Long;

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN


my $line1;
my $line2;

GetOptions( 'line1=s' => \$line1,
            'line2=s' => \$line2
) or die "error with GetOptions: $!";

my (@x, @y);
if ( $line1 =~ /    ([ - \d ]+)     # some digits, the x coordinate
                    [ \s , ]+       # a combination of comma and spaces
                    ([ - \d ]+)     # some digits, the y coordinate
                    [^ - \d ]+      # parens, spaces, commas or whatnot between pairs
                    ([ - \d ]+)     # some digits, the x coordinate
                    [ \s , ]+       # a combination of comma and spaces
                    ([ - \d ]+)     # some digits, the y coordinate
                    /xx) {
    @x = ($1, $3);
    @y = ($2, $4);
}
if ( $line2 =~ /([-\d]+) [\s,]+ ([-\d]+) [^-\d]+ ([-\d]+) [\s,]+ ([-\d]+)/x ) {      ## same regex as above
    push @x, ($1, $3);
    push @y, ($2, $4);
}

## if we didn't load 4 points bail out
for (0..3) {
    if (! defined $x[$_] or not defined $y[$_]) {
        die "improper input\nusage: ./intersection3.pl --line1 '(a,b) (c,d)' --line2 '(q,r) (s,t)'\n"
    }
}

## extract the intersection using linear algebra determinate
my $det_x_num   = (($x[0] * $y[1] - $y[0] * $x[1]) * ($x[2] - $x[3])) - (($x[0] - $x[1]) * ($x[2] * $y[3] - $y[2] * $x[3]));
my $det_y_num   = (($x[0] * $y[1] - $y[0] * $x[1]) * ($x[2] - $x[3])) - (($y[0] - $y[1]) * ($x[2] * $y[3] - $y[2] * $x[3]));
my $det_div     = (($x[0] - $x[1]) * ($y[2] - $y[3])) - (($y[0] - $y[1]) * ($x[2] - $x[3]));

my ($px, $py) = ($det_x_num/$det_div, $det_y_num/$det_div);

say "\($px, $py\)";


