#!/usr/bin/env raku

#| Given a Rational number find it's parent and grandparent in the Curious Fraction Tree
multi sub MAIN( Rat() $val ) {
    my $parent = parent($val);
    my $grandparent = parent($parent);
    say "parent = {$parent.nude.join("/")} grandparent = {$grandparent.nude.join("/")}";
}

multi sub MAIN('test') is hidden-from-USAGE {
    use Test;
    is parent(1/2), 1/1;
    is parent(1/1), Nil;
    is parent(2/5), 2/3;
    is parent(5/3), 2/3;
    done-testing;
}

subset Proper of Rat where { $^v.numerator < $^v.denominator };
subset Improper of Rat where { $^v.numerator > $^v.denominator }; 

multi sub parent( 1.0 ) { 1.0 }

multi sub parent( Proper \v ) {
    return v.numerator / (v.denominator - v.numerator);
}

multi sub parent( Improper \v ) {
    return (v.numerator - v.denominator) / v.denominator;
}
