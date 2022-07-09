#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;
use Prime::Factor;

=begin comment
Task 1: Prime Partition Submitted by: Mohammad S Anwar
Given two positive integers, $m and $n,  find out the Prime Partition
of the given number. No duplicates allowed.

Input: $m = 18, $n = 2
Output: 5, 13 or 7, 11
=end comment

constant @prime = grep { .is-prime },( 2, 3, 5, (* + 2) … ∞);

my $TEST = False;
if $TEST {
    my @test =
        { m=>7, n => 1, exp => [(7)],},
        { m=>9, n => 1, exp => [],},
        { m=>14, n => 2, exp => [(3, 11)],},
        { m=>18, n => 2, exp => [(5, 13), (7, 11)] },
        { m=>19, n => 3, exp => [(3, 5, 11), ] },
        { m=>38, n => 1, exp =>  [] },
        { m=>38, n => 2, exp =>  [( 7, 31)] },
        { m=>38, n => 3, exp =>  [
            (2, 5, 31), (2, 7, 29), (2, 13, 23), (2, 17, 19),]},
        { m=>38, n => 4, exp =>  [
             (3,5,7,23), (3,5,11,19), (3,5,13,17), (3,7,11,17),]
        },
        { m=>38, n => 5, exp =>  [ (2,3,5,11,17 ),(2,5,7,11,13)]},
        { m=>38, n => 6, exp =>  [] },
    ;
    plan @test.elems;

    for @test -> %h {
        my @got = no-dup-prime-parts(%h<m>, %h<n>);
        # XXX tests rely on ordering by .combinations being defined:
        # step through got vs exp.any
        is @got,  %h<exp>, "%h<m>, %h<n>";
    }
    exit;
}

multi sub no-dup-prime-parts( Int $n, Int $p where * == 1 --> Array) {
    return [] if not $n.is-prime;
    return [($n,)];
}

multi sub no-dup-prime-parts( Int $num where *>0,
                              Int $parts where *>1 --> Array) {
    my ($n, $p) = ($num, $parts);
    my @addend = gather for @prime { last if $_ > $n; take $_ };

    @addend.shift if $n %% 2 == $p %% 2;  # deuce not needed;

    # Could eliminate candidates in @possible by .max too great and
    # by .max too small. $n - [+] @primes[ 0 .. $k+/-] and some f(n,p)

    my @ret = gather for @addend.combinations($p) {
        .&take if $n == [+] @$_
    }
    return @ret;
}

sub MAIN( $n=5, $m=38) {
   print "Input:  \$m = $m, \$n = $n\nOutput: ";
   my $out = no-dup-prime-parts( $m, $n         # ??? formatting
             ).map( *.join(', ')
             ).join(' or ');
   say $out ?? $out !! 'No match!' ;
}

