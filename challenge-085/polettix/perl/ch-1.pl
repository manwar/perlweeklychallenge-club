#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";

use Math::Combinatorics ();

sub triplet_sum {
   my @R = grep { $_ <= 2.0 } @_; # remove cruft
   my $combiner = Math::Combinatorics->new(count => 3, data => \@R);
   while (my ($x, $y, $z) = $combiner->next_combination) {
      $x += $y + $z;
      return 1 if 1 <= $x && $x <= 2;
   }
   return 0;
};

my @input = scalar @ARGV ? @ARGV : (0.5, 1.1, 0.3, 0.7);
say triplet_sum(@input);
