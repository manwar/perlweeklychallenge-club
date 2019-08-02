#!/usr/bin/env perl6
use v6;

#
# ASSUMPTION: We are only doing subtractive notation.  I.E.
#   4 => IV, not 4 => IIII.
#

multi sub MAIN(Str:D $roman where { $^a ~~ m/^ <[ I V X L C D M ]>+ $/ } ) {
    my $num = roman-to-number($roman);
    die "Unsupported roman number format" if $roman ne decimal-to-roman($num);

    say $num;
}

multi sub MAIN(UInt:D $decimal where * > 0) {
    say decimal-to-roman($decimal);
}

multi sub MAIN(Str:D $test where * eq "test") {
    my @tests =
        XXXIX     =>   39,
        CCXLVI    =>  246,
        DCCLXXXIX =>  789,
        MMCDXXI   => 2421,
        CMXCIX    =>  999,
        CMXLIV    =>  944,
        MDCCLXXVI => 1776,
        MMMCMXCIX => 3999,
    ;

    my $TEST = 0;
    for @tests -> $kv {
        my $r = $kv.key;
        my $v = $kv.value;
       
        my $v2 = roman-to-number($r); 
        my $r2 = decimal-to-roman($v);
        say "TEST {$TEST++}: $r => $v " ~ ($v == $v2 ?? 'ok' !! "NOT OK ($v2)");
        say "TEST {$TEST++}: $r <= $v " ~ ($r eq $r2 ?? 'ok' !! "NOT OK ($r2)");
    }
}

sub roman-to-number(Str:D $roman -->Int:D) {
    my %roman-digits =
        I => 1,
        V => 5,
        X => 10,
        L => 50,
        C => 100,
        D => 500,
        M => 1000;

    my $last  = 0;
    my $total = 0;
    for $roman.comb -> $digit {
        my $val = %roman-digits{$digit};
        if $val ≤ $last {
            $total += $last;
        } else {
            $total -= $last;
        }
        $last = $val;
    }
    $total += $last;

    return $total;
}

sub decimal-to-roman(UInt:D $decimal is copy -->Str:D) {
    my $str = '';

    my @conversions =
        M  => 1000,
        CM =>  900,
        D  =>  500,
        CD =>  400,
        C  =>  100,
        XC =>   90,
        L  =>   50,
        XL =>   40,
        X  =>   10,
        IX =>    9,
        V  =>    5,
        IV =>    4,
        I  =>    1,
    ;

    for @conversions -> $pair {
        while $decimal ≥ $pair.value {
            $decimal -= $pair.value;
            $str     ~= $pair.key;
        }
    }

    return $str;
}

