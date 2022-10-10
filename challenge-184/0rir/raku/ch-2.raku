#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

=begin comment
184-2: Split Array         Submitted by: Mohammad S Anwar
Given a list of strings containing 0-9 and a-z separated by space only;
split the data into two arrays, one for integers and one for letters only.

Example 1
Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]
Example 2
Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
=end comment

sub bifurcatable( @a --> Bool) {
    my regex bifur { ^ <[ a..z \d]>* % \s $ }
    for @a -> $s {
        return False if $s eq '' or $s !~~ /<bifur>/;
    }
    True;
}

sub bifurcate( @a --> Pair ) {
    return [ [] ] => [ [] ] if @a eqv ();
    my (@n, @l);
    for @a -> $s {
        my @x = ($s.comb.grep: { m/<:Ll>/ } ).Array;
        @l.push( @x ) if @x.elems;

        my @y = map *.Int, $s.comb.grep( { m/<:Nd>/ } ).Array;
        @n.push( @y) if @y.elems;
    }
    return $@n => @l;
}

constant TEST=True;
if TEST {
    my @Test =
        { in  => (),
            exp => [] => [], },
        { in  => ( 'a', ),
            exp => [] => [['a'],], },
        { in  => ( '1', ),
            exp => [[1],] => [], },
        { in  => ( 'a b c', 'd e f' ),
            exp => [] => [['a','b','c'],['d','e','f']], },
        { in  => ( '1 2 3', '4 5 6' ),
            exp => [[1,2,3],[4,5,6]] => [], },
        { in  => ( 'a 1', ),
            exp => [[1],] => [['a'],], },
        { in  => ( 'a 1 2 b 0', '3 c 4 d'),
            exp => [[1,2,0], [3,4],] => [['a','b'], ['c','d'],], },
        { in  => ( '1 2', 'p q r', 's 3', '4 5 t'),
            exp => [[1,2], [3], [4,5],] => [['p','q','r'], ['s'], ['t'],], },
    ;
    my @Unbifurcatable =
        ( '',),
        ( ' a',),
        ( 'a ',),
        ( ' 1',),
        ( '1 ',),
        ( '1 2', 'p q r', 's 3', '4 5 t '),
        ( ',',),
        ( 'a ] c', 'd e f'),
        ( 'a *',),
        ( 'a 1 2 b 0', '3 c ) d'),
        ( '1 2', 'p + r', 's 3', '4 5 t'),
    ;
    plan 2 × @Test.elems + @Unbifurcatable;

    for @Unbifurcatable -> @u {
        is bifurcatable( @u), False, "unbifurcatable: @u[].raku()";
    }
    for @Test -> %t {
        is bifurcatable( %t<in>), True, "bifurcatable: %t<in><>.raku()";
        is-deeply bifurcate(%t<in>), %t<exp>, "Pair &bifurcate(%t<in>).raku()";
    }
    done-testing;
}

sub MAIN( @list = ( '1 2', 'p q r', 's 3', '4 5 t')) {
    die "bad data" unless bifurcatable( @list);
   my Pair $nl = bifurcate( @list);

    say 'Input: @list = ', @list.raku;
    say 'Output: ', $nl.key().raku,
        ' and ', $nl.value().raku;
}

