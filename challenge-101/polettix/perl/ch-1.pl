#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Data::Dumper;

sub pack_a_spiral (@A) {
   my $N = scalar @A;
   my $side = int sqrt $N;
   --$side if $side * $side == $N;

   my (@M, $x, $y);
   if ($side * ($side + 1) >= $N) { # rectangle
      if ($side % 2) {
         $x = ($side - 1) / 2;
         $y = $side - $x - 1;
      }
      else {
         $x = $side / 2;
         $y = $side - $x;
      }
         @M = map { [('') x ($side + 1)] } 1 .. ($side);
   }
   else { # square
      $x = $side % 2 ? (($side - 1) / 2) : $side / 2;
      $y = $side - $x;
      ++$side;
      @M = map { [('') x $side] } 1 .. $side;
   }

   $M[$y][$x] = shift @A;
   $side = 2;

   OUTER:
   while ('necessary') {
      ++$x; # move to next frame
      ++$y;
      for ([0, -1], [-1, 0], [0, +1], [1, 0]) { # four sides
         my ($dx, $dy) = $_->@*;
         for (1 .. $side) {
            last OUTER unless @A;
            $x += $dx;
            $y += $dy;
            $M[$y][$x] = shift @A;
         }
      }
      $side+=2;
   }

   return \@M;
}

sub print_matrix ($M) {
   for my $row ($M->@*) {
      for my $item ($row->@*) {
         printf '%4s ', $item;
      }
      print "\n";
   }
}

my @items = @ARGV ? @ARGV : (1..16);
my $s = pack_a_spiral(@items);
print_matrix($s);
