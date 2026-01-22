#!/usr/bin/env perl
use v5.40;

sub tuple_to_num($numer,$denom) { $numer/$denom }
sub tuple_to_fraction { tuple_to_num(@$a) <=> tuple_to_num(@$b) }

sub fractions($int) {
  return ( [1, 1], ) if $int == 1;

  my @list   = ( [1, $int], [$int, 1] );
  my @digits = $int == 2 ? 2 : 2 .. $int-1;
  foreach my $digit ( @digits ) {
    next unless $int % $digit != 0;
    push @list, [$int, $digit], [$digit, $int];                      
  }
  push @list, fractions($int - 1);
  @list
}

sub uniqFractions($int) {
  join ', ',
  map { join('/', @{$_}) }
  sort tuple_to_fraction
  fractions($int);
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  say qq/Output: @{[uniqFractions($int)]}/;
}

say "Example 1:";
solution(3);

say "\nExample 2:";
solution(4);

say "\nExample 3:";
solution(1);

say "\nExample 4:";
solution(6);

say "\nExample 5:";
solution(5);
