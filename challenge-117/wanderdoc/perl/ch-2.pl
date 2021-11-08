#!perl
use strict;
use warnings FATAL => qw(all);


=prompt
You are given size of a triangle. Write a script to find all possible paths from top to the bottom right corner.
In each step, we can either move horizontally to the right (H), or move downwards to the left (L) or right (R).

BONUS: Try if it can handle triangle of size 10 or 20.

Example 1:

Input: $N = 2

           S
          / \
         / _ \
        /\   /\
       /__\ /__\ E

Output: RR, LHR, LHLH, LLHH, RLH, LRH


Example 2:

Input: $N = 1

           S
          / \
         / _ \ E

Output: R, LH

=cut


my $N = shift or die "Size of triangle? (Warning: Output takes long by size over 10)$/"; # my $N = 10; # 1037718
my @triangle;
my $counter = 0;
for my $i ( 0 .. $N )
{

     my @row = map $counter++, 0 .. $i;

     push @triangle, [@row];
}

$counter--; # !
my %ways = (R => [1, 1], L => [1, 0], H =>[0, 1]);

# my @SOLS; # A way to save output (not recommended by size over 10).


sub find_ways
{
     my ($triangle, $x, $y, $solution) = @_;


     if ($triangle->[$x][$y] == $counter )
     {
          my $s = [@$solution];

          print join('-', @$s), $/; # push @SOLS, $s;
     }



     for my $w ( keys %ways )
     {
          my $next_x = $x + $ways{$w}->[0];
          my $next_y = $y + $ways{$w}->[1];

          if ( exists $triangle->[$next_x][$next_y] )
          {
               push @$solution, $w; 

               if (find_ways($triangle, $next_x, $next_y, $solution))
               {
                    return 1;
               }
               else
               {
                    pop @$solution;
               }

          }
     }
}

find_ways([@triangle], 0, 0, []);