# vi:et:sw=4 ts=4 ft=perl
#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use constant LARGEST_ROMAN_NUMBER => 3_999;

sub number_to_roman {
    my ($number, $debug) = @_;

    return '' if ($number > LARGEST_ROMAN_NUMBER);

    $debug //= 0;

    my %map = (
        1_000 => 'M',
        900   => 'CM',
        500   => 'D',
        400   => 'CD',
        100   => 'C',
        90    => 'XC',
        50    => 'L',
        40    => 'XL',
        10    => 'X',
        9     => 'IX',
        5     => 'V',
        4     => 'IV',
        1     => 'I',
    );

    my ($number_to_convert, @number_parts, @roman_parts) = ($number);
    foreach my $divisor (reverse sort { $a <=> $b } keys %map) {
        my $quotients = int($number_to_convert / $divisor);
        if ($quotients) {
            my $dividend = $quotients * $divisor;

            push @number_parts, $dividend;
            push @roman_parts, $map{$divisor} x $quotients;

            $number_to_convert = $number_to_convert - $dividend;
        }
    }

    my $roman = join '', @roman_parts;

    if ($debug) {
        say sprintf "%s = %s = %s = %s",
            $number,
            (join ' + ', @number_parts),
            (join ' + ', @roman_parts),
            $roman
    }

    return $roman;
}

sub roman_to_number {
    my ($roman, $debug) = @_;

    $roman = uc $roman;
    $debug //= 1;

    my %map = (
        M  => 1_000,
        CM => 900,
        D  => 500,
        CD => 400,
        C  => 100,
        XC => 90,
        L  => 50,
        XL => 40,
        X  => 10,
        IX => 9,
        V  => 5,
        IV => 4,
        I  => 1,
    );

    my ($number, @number_parts, @roman_parts) = (0);
    foreach my $char (reverse sort { $map{$a} <=> $map{$b} } keys %map) {
        while ($roman =~ s/^$char//i) {
            $number = $number + $map{$char};
            push @number_parts, $map{$char};
            push @roman_parts, $char;
        }
    }

    if ($debug) {
        say sprintf '%s = %s = %s',
            $number,
            (join ' + ', @number_parts),
            (join ' + ', @roman_parts),
    }
    return $number;
}

my @fixtures = (
    39, 246, 789, 2421, 160, 207, 1009, 1066, 1776, 1954, 2014, 2019, 3999, 4000,
);

say 'Number to Roman Numerals';
say sprintf "%s = %s\n", $_, number_to_roman($_, 1) foreach @fixtures;

say "\nRoman Numerals to Number";
say sprintf "%s = %s\n", $_, roman_to_number(number_to_roman($_), 1) foreach @fixtures;

1;

__END__

$ perl ch-1.pl
Number to Roman Numerals
39 = 30 + 9 = XXX + IX = XXXIX
39 = XXXIX

246 = 200 + 40 + 5 + 1 = CC + XL + V + I = CCXLVI
246 = CCXLVI

789 = 500 + 200 + 50 + 30 + 9 = D + CC + L + XXX + IX = DCCLXXXIX
789 = DCCLXXXIX

2421 = 2000 + 400 + 20 + 1 = MM + CD + XX + I = MMCDXXI
2421 = MMCDXXI

160 = 100 + 50 + 10 = C + L + X = CLX
160 = CLX

207 = 200 + 5 + 2 = CC + V + II = CCVII
207 = CCVII

1009 = 1000 + 9 = M + IX = MIX
1009 = MIX

1066 = 1000 + 50 + 10 + 5 + 1 = M + L + X + V + I = MLXVI
1066 = MLXVI

1776 = 1000 + 500 + 200 + 50 + 20 + 5 + 1 = M + D + CC + L + XX + V + I = MDCCLXXVI
1776 = MDCCLXXVI

1954 = 1000 + 900 + 50 + 4 = M + CM + L + IV = MCMLIV
1954 = MCMLIV

2014 = 2000 + 10 + 4 = MM + X + IV = MMXIV
2014 = MMXIV

2019 = 2000 + 10 + 9 = MM + X + IX = MMXIX
2019 = MMXIX

3999 = 3000 + 900 + 90 + 9 = MMM + CM + XC + IX = MMMCMXCIX
3999 = MMMCMXCIX

4000 =


Roman Numerals to Number
39 = 10 + 10 + 10 + 9 = X + X + X + IX
39 = 39

246 = 100 + 100 + 40 + 5 + 1 = C + C + XL + V + I
246 = 246

789 = 500 + 100 + 100 + 50 + 10 + 10 + 10 + 9 = D + C + C + L + X + X + X + IX
789 = 789

2421 = 1000 + 1000 + 400 + 10 + 10 + 1 = M + M + CD + X + X + I
2421 = 2421

160 = 100 + 50 + 10 = C + L + X
160 = 160

207 = 100 + 100 + 5 + 1 + 1 = C + C + V + I + I
207 = 207

1009 = 1000 + 9 = M + IX
1009 = 1009

1066 = 1000 + 50 + 10 + 5 + 1 = M + L + X + V + I
1066 = 1066

1776 = 1000 + 500 + 100 + 100 + 50 + 10 + 10 + 5 + 1 = M + D + C + C + L + X + X + V + I
1776 = 1776

1954 = 1000 + 900 + 50 + 4 = M + CM + L + IV
1954 = 1954

2014 = 1000 + 1000 + 10 + 4 = M + M + X + IV
2014 = 2014

2019 = 1000 + 1000 + 10 + 9 = M + M + X + IX
2019 = 2019

3999 = 1000 + 1000 + 1000 + 900 + 90 + 9 = M + M + M + CM + XC + IX
3999 = 3999

0 =  =
4000 = 0
