#!/usr/bin/env raku

use v6;

#| Given a list of unsigned integers how many need to be made negative to make the smallest positive sum
sub MAIN ( *@N where { $_.all ~~ UInt } ) {
    my @flips = lazy gather {
        my $elems = @N.elems;
        my @negs = -1 xx $elems;
        my $max = (2 ** $elems) - 1;
        my $sfmt = "\%0{$elems}d";
        for 0..$max -> $n {
            take @negs [Z+] sprintf($sfmt, $n.base(2) ).comb().map(* * 2);
        }
    };

    my $min = Inf;
    my $min-flips = Inf;
    for @flips -> @f {
        my $s = [+] ( @f [Z*] @N );
        next if $s < 0;
        next if $s > $min;
        $min = $s;
        $min-flips = Inf;
        my $cflips = @f.grep(* < 0).elems;
        next if $cflips > $min-flips;
        $min-flips = $cflips;
    }
    say $min-flips;
}

