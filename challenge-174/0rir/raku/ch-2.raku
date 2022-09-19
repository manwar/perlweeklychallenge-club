#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;
#use lib $?FILE.IO.parent(2).add("lib");

=begin comment
Task 2: Permutation Ranking     Submitted by: Mohammad S Anwar

Given a list of integers with no duplicates, e.g. [0, 1, 2].
Write permutation2rank() which takes the list and determines its rank (0...n)
in lexicographic order within all permutations
Also write rank2permutation() which takes the list and an int to produce the
permutation at that rank.

Given the list [0, 1, 2] the ordered permutations are:
[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0],

so:
permutation2rank([1, 0, 2]) = 2
rank2permutation([0, 1, 2], 1) = [0, 2, 1]

Added sets that are ordinal sequences when sorted and when provide the
set allow any rank to be constructed.
=end comment

my constant @factorial = gather do {
    take 1;
    loop { state ($p, $n) = (1, 1); take $p *= $n++; }
}                                                           # blocking

constant TEST=False;

if TEST {
    my @Test =
        { in => [ 0,], rank => 0 },

        { in => [ 0, 1,], rank => 0 },
        { in => [ 1, 0,], rank => 1 },

        { in => [ 0, 1, 2,], rank => 0 },
        { in => [ 1, 0, 2,], rank => 2 },
        { in => [ 2, 0, 1,], rank => 4 },
        { in => [ 2, 1, 0,], rank => 5 },

        { in => [ 0, 1, 3, 2,], rank => 1 },
        { in => [ 0, 2, 3, 1,], rank => 3 },
        { in => [ 0, 3, 2, 1,], rank => 5 },

        { in => [ 1, 0, 2, 3,], rank => 6 },
        { in => [ 1, 2, 0, 3,], rank => 8 },
        { in => [ 1, 3, 0, 2,], rank => 10 },

        { in => [ 2, 0, 3, 1,], rank => 13 },
        { in => [ 2, 1, 3, 0,], rank => 15 },
        { in => [ 2, 3, 1, 0,], rank => 17 },

        { in => [ 3, 0, 1, 2,], rank => 18 },
        { in => [ 3, 1, 0, 2,], rank => 20 },
        { in => [ 3, 2, 0, 1,], rank => 22 },
        

        { in => [ 5, 0, 4, 1, 7, 3, 2, 6], rank => 25580 },
        { in => [ 4, 5, 3, 2, 0, 1 ], rank => 598 },
        { in => [ 4, 8999, 3, -99, -8999, -91111111 ], rank => 598 },
        { in => [ 0, 1, 1111122332100000, 2, 3, 4, 5, 6, 7, 8, 9], rank => 0 },
        { in => [ 599999, -1, 42, -2, 9999, 3, 234, 6], rank => 25580 },
        { in => [ -99999, -7, 30, 1900], rank => 7 },
        { in => [ 905, -720, -9, 9,], rank => 18 },
        { in => [ 3, 0, 1, 2,], rank => 18 },
    ;

    plan 2 × @Test.elems;

    for @Test -> %t {
        is permutation2rank( %t<in>), %t<rank>, "%t<in> --> %t<rank>";
        is rank2permutation( %t<rank>, %t<in>), %t<in>,
                "%t<rank> --> %t<in>"; 
    }
    done-testing;
    exit;
}

# Return the rank of a permutation of {0,..,$n-1} by lexicographical order
sub permutation2rank( @pin is copy --> Int ){
        # normalizer -- converter to 0 to N sequence
    my %normalizer =        # XXX re-stringing
            @pin.sort(*leg*).flat Z=> ("0"..@pin.end).flat;
    my @p = map { %normalizer{$_} }, @pin;

    my $n = @p.end;
    my $fact = @factorial[$n];
    my $rank = 0;
    my @digit = 0 .. $n;

    for 0..$n - 1 -> $i {
        my $q = @digit.first( @p[$i], :k);
        $rank += $fact * $q;
        @digit.splice: $q, 1;
        $fact = @factorial[ $n - 1 - $i];
    }
    return $rank;
}

multi sub rank2permutation(Int $r, @elems-set --> Array) {

    my @index = @elems-set.sort(*leg*);
    my %denormalizer = ["0"...@index.end] Z=> [ @index ];
    return @ = map { %denormalizer{$_} },
        rank2permutation( $r, @elems-set.elems); 
}

multi sub rank2permutation(Int $r is copy, Int $n is copy --> Array){
    --$n;
    my $fact = @factorial[$n];
    my @digit = 0..$n;
    my @p;
    for 0..$n -> $i {
        my $q = ($r ÷ $fact).floor;
        $r %= $fact;
        @p.append(@digit[$q]);
        @digit.splice: $q, 1;   # remove this digit @p[$i]
        if $i != $n - 1 {
            $fact = @factorial[$n - 1 - $i];
        }
    }
    $fact.Bool;  # silence DESTROY since it can be out of bounds
    return @p;
}

sub MAIN( ) {
    say " Permutations to lexicographic rank and back\n";
    my @in = [ 5, 0, 4, 1, 7, 3, 2, 6];
    say "permutation2rank( @in.raku() ) --> ", permutation2rank( @in );
    die 'stupid' unless 25580 == permutation2rank( @in );
    say "rank2permutation( 25580, 8) --> ", rank2permutation( 25580, 8 ), "\n";

    @in = [-99999, -7, 30, 1900]; #7
    say "permutation2rank( @in.raku() ) --> ", permutation2rank(@in );
    die 'stupid' unless 7 == permutation2rank( @in );
    say "rank2permutation( 7, 4) --> ", rank2permutation( 7, 4 ), "\n";

    @in = [ 905, -720, -9, 9,];#18
    say "permutation2rank(", @in,") --> ", permutation2rank( @in );
    die 'stupid' unless 18 == permutation2rank( @in );

           # sort as shuffle
    say "rank2permutation( 18, [ @in.sort.join(', ') ]) --> ",
        rank2permutation( 18, @in.sort ), "\n";
}
