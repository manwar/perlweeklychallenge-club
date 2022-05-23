#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use ARGV::OrDATA;
use List::Util qw{ sum };

=head1 Usage

ch-2.pl input_file | ch-1.pl - > out.svg

=cut

my @points;
while (<>) {
    push @points, map [split /,/], split;
}

my ($min_x, $max_x, $min_y, $max_y)
    = (($points[0][0]) x 2, ($points[0][1]) x 2);
for my $point (@points[1 .. $#points]) {
    $min_x = $point->[0] if $point->[0] < $min_x;
    $min_y = $point->[1] if $point->[1] < $min_y;
    $max_x = $point->[0] if $point->[0] > $max_x;
    $max_y = $point->[1] if $point->[1] > $max_y;
}

my $sum_x        = sum(map $_->[0], @points);
my $sum_y        = sum(map $_->[1], @points);
my $sum_x_square = sum(map $_->[0] * $_->[0], @points);
my $sum_xy       = sum(map $_->[0] * $_->[1], @points);

my $divisor = @points * $sum_x_square - $sum_x * $sum_x;
my $slope = (@points * $sum_xy - $sum_x * $sum_y)
          / ($divisor || 1);

my $intercept = ($sum_y - $slope * $sum_x) / @points;

my @line;
push @line, ($_, $intercept + $_ * $slope) for $min_x, $max_x;

# Vertical.
if ($line[0] == $line[2] && $line[1] == $line[3]) {
    $line[1] = $points[0][1];
    $line[3] = $points[1][1];
}

{   local $, = ',';
    say @$_ for @points;
    say @line;
}

__DATA__
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
