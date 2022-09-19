#!/usr/bin/env perl
use strict;
use warnings;

use List::Util 'sum';

use lib 'lib';
use Plot ();

## Task 2: Line of Best Fit
# When you have a scatter plot of points, a line of best fit is the line that 
# best describes the relationship between the points, and is very useful in
# statistics. Otherwise known as linear regression, here is an example of what 
# such a line might look like:
#
# The method most often used is known as the least squares method, as it is 
# straightforward and efficient, but you may use any method that generates 
# the correct result.
#
# Calculate the line of best fit for the following 48 points
#
# 333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
# 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
# 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
# 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
# 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
# 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
#
# Using your rudimentary graphing engine from Task #1, graph all points, 
# as well as the line of best fit.

# read the input and get all the points
my @points = map { [ split /,/ ] } split /\s+/, do { local $/; <DATA> };

# get all the bits for the calculation
my ( @x_squared, @x_y, @x, @y );
foreach my $p (@points) {
    push @x_squared, $p->[0]**2;
    push @x_y,       $p->[0] * $p->[1];
    push @x,         $p->[0];
    push @y,         $p->[1];
}
my $number_of_points = @points;

# m is the Slope of the line
my $m = ( $number_of_points * sum(@x_y) - sum(@x) * sum(@y) ) /
  ( $number_of_points * sum(@x_squared) - sum(@x)**2 );
# b is the Y intercept
my $b = ( sum(@y) - $m * sum(@x) ) / $number_of_points;

# Plot all the points, plus one line based on the function
# with the values we've calculated, for 1 and a number higher
# than the highest one in the input.
Plot::plot( @points, [ map { $_, $m * $_ + $b } 1, 400 ] );

__DATA__
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
