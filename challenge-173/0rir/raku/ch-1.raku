#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;
use Colorizable;

=begin comment
Task 1: Esthetic Number ￼       Submitted by: Mohammad S Anwar

Given a positive integer, $n, find out if the given number is
an Esthetic Number; which is a positive integer where every adjacent
digit differs from its neighbour by 1.
For example,
    5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
    120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1
=end comment

constant TEST=False;

if TEST {
    my @True = 10,  12,  21,  23,  32,  34,  43,  45,  54,  56,
               65,  67,  76,  78,  87,  89,  98, 101, 121, 123,
              210, 212, 232, 234, 321, 323, 343, 345, 432, 434,
              454, 456, 543, 545, 565, 567, 654, 656, 676, 678,
              765, 767, 787, 789, 876, 878, 898, 987, 989;
    my @False = 123456789876543212345678987654321012345678901;
    my @True-more = 1234567898765432123456789876543210123456789;

    plan 2 × (110 + @True.elems + @True-more.elems + @False.elems );
    for (1..10,151..200,951..1000).flat {
        if @True.any == $_ {
            is is-esthetic( $_), True, "True $_" ;
        } else {
            is is-esthetic( $_), False, "False $_";
        }
        is .&is-esthetic, .&_is-esthetic-explain, 'explain matches';
    }
    for ( @True, @True-more).flat {
        is is-esthetic( $_), True, "True $_";
        is .&is-esthetic, .&_is-esthetic-explain, 'explain matches';
    }
    for @False {
        is is-esthetic( $_), False, "False $_";
        is .&is-esthetic, .&_is-esthetic-explain, 'explain matches';
    }
    done-testing;
    exit;
}

sub is-esthetic( Int $n where * > 0 ) {
    return False if $n < 10;
    $_ = $n.Str.split('').rotor( 2 => -1).Array;
    .pop;
    .shift;
    not so $_.first: { abs( $_[0] - $_[1] ) ≠ 1};
}

sub _is-esthetic-explain ( $n where * > 0 ) {
    if $n < 10 {
        my $s = "too short" but Colorizable;
        print "$n is not esthetic since it is";
        say $s.colorize: red;
        return False
    }

    $_ = $n.Str.split('').rotor( 2 => -1).Array;
    .pop;
    .shift;
    my $esthetic = $_;
    if not so $_.first( { abs( $_[0] - $_[1] ) ≠ 1} ) {
        for @$esthetic -> $dyad is rw { $dyad = @$dyad.join(' - '); }
        say "$n is esthetic since |" ~ @$esthetic.join('| = |') ~ '| = 1';
        return True;
    } else {
        print "$n is not esthetic since ";
        for @$esthetic -> $dyad {
            print '|';
            if  abs( $dyad[0] - $dyad[1] ) ≠ 1 {
                my $s = "@$dyad.join(' - ')" but Colorizable;
                print $s.colorize: red
            } else {
                print ( @$dyad.join(' - '));
            }
        }
        my $t = '= 1' but Colorizable;
        say '| ' ~ $t.colorize: red;
        return False;
    }
}

sub MAIN( $i = 154234) {
    _is-esthetic-explain( $i );
}


