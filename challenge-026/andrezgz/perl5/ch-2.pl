#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-026/
# Task #2
# Create a script that prints mean angles of the given list of angles in degrees.
# Please read wiki page that explains the formula in details with an example.
# https://en.wikipedia.org/wiki/Mean_of_circular_quantities

use strict;
use warnings;
use Math::Trig qw/rad2deg deg2rad/;

die "Usage: $0 angle-deg [angle-deg..]" if @ARGV < 1;
die "Angles should be numbers (in degrees)" if grep { $_ !~ /\d+/ } @ARGV;
my @angles = map {deg2rad $_} @ARGV;

my ($sin_sum,$cos_sum) = (0,0);
foreach my $angle (@angles) {
    $sin_sum += sin $angle;
    $cos_sum += cos $angle;
}

if (abs $cos_sum < 1e-10 ) {
    print 'Mean angle: ? (Cosine sum is zero)';
    exit 0;
}

#Scaling does not matter for atan2, no need to calculate sin and cos means
my $angles_mean = rad2deg atan2 $sin_sum, $cos_sum;

if    ($cos_sum < 0 ) {$angles_mean +=180}
elsif ($sin_sum < 0 ) {$angles_mean +=360}

$angles_mean -= 360 if $angles_mean > 180; #analogous angle
print 'Mean angle: '.$angles_mean;
