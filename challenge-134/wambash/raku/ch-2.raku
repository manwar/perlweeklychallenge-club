#!/usr/bin/env raku

class DistinctTermsCount {
    has Int $.m;
    has Int $.n;

    has $.table;
    has $.distinct-terms handles count => <elems>;

    submethod TWEAK () {
        with (1..$!m X* 1..$!n).cache {
            $!table := .batch(3);
            $!distinct-terms := .unique;
        }
    }
}

multi MAIN (Bool :test($)!){
    use Test;
    is-deeply DistinctTermsCount.new(:3m,:3n).table, ((1,2,3),(2,4,6),(3,6,9));
    is DistinctTermsCount.new(:3m,:3n).distinct-terms, <1 2 3 4 6 9>;
    is DistinctTermsCount.new(:3m,:3n).count, 6;
    is DistinctTermsCount.new(:3m,:5n).distinct-terms, <1 2 3 4 5 6 8 10 9 12 15>;
    is DistinctTermsCount.new(:3m,:5n).count, 11;
    done-testing;
}
