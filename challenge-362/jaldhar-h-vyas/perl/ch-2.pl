#!/usr/bin/perl
use 5.038;
use warnings;

sub numberToEnglish($n) {
    state %ones = (
        0 => 'zero',
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine'
    );
    
    state %teens = (
        10 => 'ten',
        11 => 'eleven',
        12 => 'twelve',
        13 => 'thirteen',
        14 => 'fourteen',
        15 => 'fifteen',
        16 => 'sixteen',
        17 => 'seventeen',
        18 => 'eighteen',
        19 => 'nineteen'
    );
    
    state %tens = (
        20 => 'twenty',
        30 => 'thirty',
        40 => 'forty',
        50 => 'fifty', 
        60 => 'sixty',
        70 => 'seventy',
        80 => 'eighty',
        90 => 'ninety'
    );
    
    if ($n == '0') {
        return $ones{0};
    }
    
    my $abs = abs($n);
    my @parts;
    
    if ($abs >= 1_000_000_000) {
        push @parts, numberToEnglish(int($abs / 1_000_000_000)) . ' billion';
        $abs %= 1_000_000_000;
    }
    
    if ($abs >= 1_000_000) {
        push @parts, numberToEnglish(int($abs / 1_000_000)) . ' million';
        $abs %= 1_000_000;
    }
    
    if ($abs >= 1_000) {
        push @parts, numberToEnglish(int($abs / 1_000)) . ' thousand';
        $abs %= 1000;
    }
    
    if ($abs >= 100) {
        push @parts, $ones{int($abs / 100)} . ' hundred';
        $abs %= 100;
    }
    
    if ($abs >= 20) {
        my $tensVal = int($abs / 10) * 10;
        my $onesVal = $abs % 10;
        if ($onesVal == 0) {
            push @parts, %tens{$tensVal};
        } else {
            push @parts, "$tens{$tensVal}-$ones{$onesVal}";
        }
    } elsif ($abs >= 10) {
        push @parts, $teens{$abs};
    } elsif ($abs > 0) {
        push @parts, $ones{$abs};
    }
    
    my $result = join q{ }, @parts;
    return ($n < 0) ? "negative $result" : $result;
}

my @ints = @ARGV;

say join q{, }, sort { numberToEnglish($a) cmp numberToEnglish($b) } @ints;
