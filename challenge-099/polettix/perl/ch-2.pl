#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub unique_subsequence ($S, $T) {
   my $lenT = length $T or return 1;
   my $lenS = length $S or return 0;
   my $first = substr $T, 0, 1, '';
   --$lenT;
   my $s = 0; # sum
   my $p = 0; # search start position
   while (($p < $lenS) && (my $i = index $S, $first, $p) >= $p) {
      $s += unique_subsequence(substr($S, $i), $T) if $lenS - $i >= $lenT;
      $p = $i + 1;
   }
   return $s;
}

sub unique_subsequence_rx ($S, $T) {
   $T = join '.*', split m{}mxs, $T;
   my $count = 0;
   1 while $S =~ m{$T(?{++$count})(?!)};
   return $count;
}

my $string = shift // 'littleit';
my $subsequence = shift // 'lit';
say unique_subsequence($string, $subsequence);
say unique_subsequence_rx($string, $subsequence);
