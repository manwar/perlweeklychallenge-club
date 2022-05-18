#!/usr/bin/env perl
#
# gen_points.pl - Generate random points around a slope and y-intercept
#
# This is designed to be used as the input to ./ch-2.pl. It is also the
# script I used to generate the input points for task #2.
#
# The best fit line generated from the resulting points is not guaranteed
# to have the precise slope and y-intercept specified here! However, in
# practice, it is very close, especially when the count of points is high.
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

use Math::Trig;
use Getopt::Long;

no warnings 'uninitialized';

my %o = (width => 400, 
        height => 300, 
        points => 100, 
         slope => 0.5, 
     intercept => 50);

my @opt = qw< width=i height=i points=i slope|m=f intercept|b=f >;
my $opt = join ' ', map { /^(.+)=/; "--$1=N" } @opt;
GetOptions(\%o, @opt) or die "Usage: $0 [$opt]\n";

say join ',', @$_ for generate_points($o{slope}, $o{intercept});

# Pick good random points around a given slope and y intercept
sub generate_points {
    my ($m, $b) = @_;

    my $angle = atan($m);

    map { 
        my $x = rand($o{width});
        my $y = $m*$x + $b;

        # Perturb the points more towards the right
        my $dev = 100 + $x/3; # hypotenuse
        my $ydev = $dev * sin($angle);
        $y += rand($ydev) - $ydev/2;

        [ map { int } $x, $y ]
    } 1..$o{points};
}
