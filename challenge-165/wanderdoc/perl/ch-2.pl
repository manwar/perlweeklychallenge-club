#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Calculate the line of best fit for the following 48 points:
...
Using your rudimentary graphing engine from Task #1, graph all points, as well as the line of best fit.
=cut





use List::Util qw(reduce);
use FindBin qw($Bin);

use lib $Bin;
use my_svg;


my $input = <<'POINTS';
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
POINTS


my @pts = map { my %h; @h{qw(x y)} = split(/,/, $_); \%h; } 
               split(/\s+/, $input);
my ( $slope, $intercept ) = calculate_best_fit(@pts);
my ($x_1, $x_2) = (sort{$a <=> $b} map $_->{x} , @pts)[0, -1];
my @lines;
push @lines, create_line($x_1, $x_2, $slope, $intercept);



my $output_svg = create_svg(\@pts, \@lines, $slope, $intercept);
open my $out, ">", "$Bin/output_task2.svg" or die "$!";
print {$out} $output_svg;


sub calculate_best_fit
{
     my @points = @_;

     my $N = scalar @points;

     # Step 1: For each (x,y) point calculate x^2 and xy:
     my @x_sq = map $_->{x} * $_->{x}, @points;

     my @xy   = map $_->{x} * $_->{y}, @points;
     
     # Step 2: Sum all x, y, x^2 and xy:

     my $sum_x = reduce { $a + $b->{x} } 0, @points;
     my $sum_y = reduce { $a + $b->{y} } 0, @points; 
     my $sum_x_sq = reduce {$a + $b } @x_sq;
     my $sum_xy = reduce {$a + $b} @xy;

     # Step 3: Calculate slope m:
     my $m =  ($N * $sum_xy - $sum_x * $sum_y) / 
              ($N * $sum_x_sq - ($sum_x * $sum_x));
     
     # Step 4: Calculate Intercept b:
     my $intrcpt = ($sum_y - $m * $sum_x) / $N;

     return ($m, $intrcpt);

}



sub create_line
{
     my ( $x1, $x2, $slp, $itr ) = @_;
     my $y1 = int( $slp * $x1 + $itr );
     my $y2 = int( $slp * $x2 + $itr );
     return {x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2};
}