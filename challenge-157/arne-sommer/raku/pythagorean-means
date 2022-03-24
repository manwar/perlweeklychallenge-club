#! /usr/bin/env raku

unit sub MAIN (*@n where @n.elems > 0 && all(@n) ~~ Int);

my $n  = @n.elems;
my $am = (@n.sum / $n);
my $gm = ([*] @n).abs.roots($n)[0].Real;
my $hm = $n / @n.map( { 1/$_ } ).sum;

say "AM = { $am.round(0.1).fmt('%.1f') }, ",
    "GM = { $gm.round(0.1).fmt('%.1f') }, ",
    "HM = { $hm.round(0.1).fmt('%.1f') }";
