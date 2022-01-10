#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my %q = map { $_=>$_ } (my @p = (0,1));

for(my $o=2;;$o++) {
  $q{$p[$o] ||= $o*(3*$o-1)/2}||=$o;
  for(my $i=1, ($q{$p[$o]||=$o*(3*$o-1)/2}||=$o);$i<$o;$i++) {
    next unless my $t = $q{$p[$o]-$p[$i]};
    (push(@p, @p * (3*@p-1)/2), $q{$p[-1]}=@p) while $p[$o]+$p[$i] > $p[-1];
    next unless my $s = $q{$p[$o]+$p[$i]};
    say "First 2 pents are: p($o) = $p[$o], p($i) = $p[$i], p($o) + p($i) = ",
        $p[$o]+$p[$i]," = p($s), p($o) - p($i) = ",$p[$o]-$p[$i]," = p($t)";
    exit;
  }
}

