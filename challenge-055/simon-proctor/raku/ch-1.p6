#!/usr/bin/env raku

use v6;

#| Given a binary string find the start and end points for flipping the bits that results in the most 1's in the final string
sub MAIN( Str $bin where { m!^ <[10]>+ $! } ) {
    my @bin = $bin.comb;

    my @results;
    my $len = 0;

    for 0..@bin.elems-1 -> $l {
        for $l..@bin.elems-1 -> $r {
            my @res = flip(@bin,$l,$r);
            given @res.grep(* == 1).elems {
                when * > $len {
                    $len = $_;
                    @results = [ { l => $l, r => $r, bin => @res.join("") }, ];
                }
                when $len {
                    @results.push( { l => $l, r => $r, bin => @res.join("") } );
                }
            }
        }
    }
    say "Max 1's : {$len}";
    say "{$_<l>} -> {$_<r>} : {$_<bin>}" for @results;
}

sub flip( @bin is copy, $l, $r ) {
    @bin[$l..$r] = @bin[$l..$r].map( { abs($_-1) } );
    @bin;
}

