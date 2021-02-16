#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'min';

sub triangle_sum ($tri) {
   my @s = $tri->[0][0];
   my $i = 1;
   while ($i <= $tri->$#*) {
      my $l = $tri->[$i];
      my @ns = $s[0] + $l->[0];
      push @ns, $l->[$_] + ($s[$_ - 1] < $s[$_] ? $s[$_ - 1] : $s[$_])
         for 1 .. $l->$#* - 1;
      push @ns, $s[-1] + $l->[-1];
      @s = @ns;
      ++$i;
   }
   return min(@s);
}

sub triangularize (@list) {
   my @retval;
   my $n = 1;
   while (@list) {
      die "invalid number of elements\n" unless @list >= $n;
      push @retval, [splice @list, 0, $n];
      ++$n;
   }
   return \@retval;
}

my @list = @ARGV ? @ARGV : qw< 1 2 4 6 4 9 5 1 7 2 >;
say triangle_sum(triangularize(@list));
