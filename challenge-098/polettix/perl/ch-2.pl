#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub search_insert_position ($aref, $new_item) {
   my ($lo, $hi, $i) = (0, $aref->$#*, undef);
   while ($lo <= $hi) {
      $i = int(($lo + $hi) / 2);
      my $item = $aref->[$i];
      if ($new_item == $item)   { return $i }
      elsif ($new_item < $item) { $hi = $i }
      else                      { $lo = $i }
      last if ($hi - $lo) <= 1;
   }
   splice $aref->@*, $i, 0, $new_item;
   return $i;
}

my $N = @ARGV ? shift @ARGV : 3;
my @N = @ARGV ? @ARGV : qw< 1 2 3 4 >;
my $i = search_insert_position(\@N, $N);
say "$i -> (@N)";
