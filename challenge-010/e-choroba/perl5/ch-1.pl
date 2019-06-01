#!/usr/bin/perl
use warnings;
use strict;

{   my %from_roman = (
        I => 1,
        V => 5,
        X => 10,
        L => 50,
        C => 100,
        D => 500,
        M => 1000,
    );
    sub from_roman {
        my ($roman) = @_;
        my $n = 0;
        while ($roman =~ s/(I[VXLCDM]|X[LCDM]|C[DM])//) {
            my ($minus, $plus) = split //, $1;
            $n += $from_roman{$plus} - $from_roman{$minus};
        }
        $n += $from_roman{$_} for split //, $roman;
        return $n
    }

    my %to_roman = reverse %from_roman;
    my %subtractive = (
        'IIII'  => 'IV',
        'VIIII' => 'IX',
        'XXXX'  => 'XL',
        'LXXXX' => 'XC',
        'CCCC'  => 'CD',
        'DCCCC' => 'CM',
    );
    my $subtractive_re = join '|',
                         sort { length $b <=> length $a }
                         keys %subtractive;
    sub to_roman {
        my ($n) = @_;
        my $roman = "";
        while ($n) {
            for my $i (sort { $b <=> $a } keys %to_roman) {
                while ($n >= $i) {
                    $n -= $i;
                    $roman .= $to_roman{$i};
                }
            }
        }
        $roman =~ s/($subtractive_re)/$subtractive{$1}/g;
        return $roman
    }
}


use Test::More;

my %test = (XXXIX     => 39,
            CCXLVI    => 246,
            DCCLXXXIX => 789,
            MMCDXXI   => 2421,
            CLX       => 160,
            CCVII     => 207,
            MIX       => 1009,
            MLXVI     => 1066,
            MDCCLXXVI => 1776,
            MCMIII    => 1903,  # MDCDIII
            MCMX      => 1910,
            MCMLIV    => 1954,
            MCMXCIX   => 1999, # MIM
            MMXIX     => 2019,
            MMMCMXCIX => 3_999);

for my $roman (keys %test) {
    is from_roman($roman), $test{$roman};
}

for my $roman (keys %test) {
    is to_roman($test{$roman}), $roman;
}

done_testing();
