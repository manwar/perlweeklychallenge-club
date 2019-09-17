#!/usr/bin/perl
use strict;
use Math::Trig;

# Create a script that prints mean angles of the given list of angles in degrees. Please read see 
# https://en.wikipedia.org/wiki/Mean_of_circular_quantities
# that explains the formula in details with an example

my @angles = @ARGV;
my $count = scalar(@angles);
my $x;
my $y;
foreach (@angles) {
	$x += cos($_ * pi/180);
	$y += sin($_ * pi/180);
}

my $angle_mean = atan2( $y/$count, $x/$count) * 180/pi;
print "The mean of angles ", join(',',@angles), " is $angle_mean\n";

__END__

/ch-2.pl 10 20 30
The mean of angles 10,20,30 is 20

./ch-2.pl 355 5 15
The mean of angles 355,5,15 is 5

./ch-2.pl 5 10 15 20 25 30 35
The mean of angles 5,10,15,20,25,30,35 is 20

./ch-2.pl 180 270 360
The mean of angles 180,270,360 is -90

