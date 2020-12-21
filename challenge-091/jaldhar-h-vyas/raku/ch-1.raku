#!/usr/bin/raku

sub MAIN(
    Int $N  #= a positive number.
) {
    my %count = $N.comb.classify({ $_; });
 
    for %count.keys.sort -> $k {
        print %count{$k}.elems, $k;
    }
 
    print "\n";
}