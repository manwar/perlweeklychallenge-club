#!/usr/bin/env raku
use v6;
sub MAIN ($foo = '12-01 20-01', $bar = '15-01 18-01') {
   my @foo = $foo.split(/\s+/);
   my @bar = $bar.split(/\s+/);
   put days-together(@foo, @bar);
}

sub days-together (@foo, @bar) {
   my $start = (@foo[0], @bar[0]).map({date-to-index($_)}).max;
   my $stop  = (@foo[1], @bar[1]).map({date-to-index($_)}).min;
   return (0, $stop - $start + 1).max;
}

sub date-to-index ($date) {
   state @days-upto = days-upto();
   my ($d, $m) = $date.split(/\-/).map: * + 0;
   return @days-upto[$m - 1] + $d;
}

sub days-upto {
   my $sum = 0;
   <0 31 28 31 30 31 30 31 31 30 31 30 31>.map: $sum += *;
}
