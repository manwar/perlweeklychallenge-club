#!/usr/bin/perl
# The Weekly Challenge 165
# Task 2 Line of Best Fit
# Usage: $ ch-2.pl
use v5.24.0;
use warnings;
use List::Util qw/min max sum/;
use ARGV::OrDATA;

my @points;

while (<>) {
    chomp;
    my @new_points = /\S+/g;
    @new_points = map { [split ",", $_]} @new_points;
    push @points, @new_points; 
}

my $n = scalar @points;

my $slope = 
     (  $n * sum(map {$_->[0]*$_->[1]} @points)  # n sum(xy) - sum(x) sum(y)
      - sum(map{$_->[0]} @points) * sum(map{$_->[1]} @points) ) 
    / ( $n * sum(map{$_->[0]**2} @points)        # n sum(sq x) - sq(sum x)
         - (sum( map { $_->[0]} @points ))**2) ;


my $intercept =
     ( sum( map {$_->[1]} @points )             # sum(y) - slope * sum(x)
    - $slope * sum( map {$_->[0]} @points) )
    / $n ;

sub y_best_fit {
    my $x = $_[0];
    return $slope*$x + $intercept;
}

my $minx = min( map {$_->[0]} @points );
my $maxx = max( map {$_->[0]} @points );

my $line_of_best_fit = 
    join ",", $minx,y_best_fit($minx),$maxx,y_best_fit($maxx);

open FH, "> BEST_FIT_DATA" or die $!;
say FH $line_of_best_fit;
say FH $_->[0],",",$_->[1] for @points;

system("perl ch-1.pl < BEST_FIT_DATA > new.svg"); # applicable on Linux



__DATA__
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
