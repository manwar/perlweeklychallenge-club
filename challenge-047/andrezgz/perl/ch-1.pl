#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/
# Task #1
# Roman Calculator
#
# Write a script that accepts two roman numbers and operation.
# It should then perform the operation on the give roman numbers and print the result.
#
# For example,
#
# perl ch-1.pl V + VI
# It should print
#
# XI

use strict;
use warnings;

my %roman_table = (
    'I'  => 1,
    'IV' => 4,
    'V'  => 5,
    'IX' => 9,
    'X'  => 10,
    'XL' => 40,
    'L'  => 50,
    'XC' => 90,
    'C'  => 100,
    'CD' => 400,
    'D'  => 500,
    'CM' => 900,
    'M'  => 1000
);

my $operations = {
    '+' => sub { $_[0] + $_[1] },
    '-' => sub { $_[0] - $_[1] },
    'x' => sub { $_[0] * $_[1] },
    '/' => sub { $_[0] / $_[1] },
};

die 'Two roman numbers and an operation are required'
    unless @ARGV == 3;

my $rn1 = shift;
die 'Invalid first roman number'
    unless _is_valid_roman($rn1);

my $op = shift;
die 'Valid operations are: '. join ' ', keys %{$operations}
    unless exists $operations->{$op};

my $rn2 = shift;
die 'Invalid second roman number'
    unless _is_valid_roman($rn2);

# The usage of a dispatch table for the operations was taken from
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-039/andrezgz/perl5/ch-2.pl
my $result = $operations->{$op}->( decode_roman(uc $rn1) , decode_roman(uc $rn2) );
die 'Result cannot be expressed as a roman number: ' . $result
    unless ( $result > 0 && int $result == $result);

print encode_roman($result);

exit 0;

# The following subroutines were taken from
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-010/andrezgz/perl5/ch-1.pl

sub _is_valid_roman {
    return $_[0] =~ /
                        ^                       # String start
                        M{0,3}                  # Matching from 1000 to 3000
                        (?:CM|CD|D|D?C{0,3})?   # Matching from 100 to 900
                        (?:XC|XL|L|L?X{0,3})?   # Matching from 10 to 90
                        (?:IX|IV|V|V?I{0,3})?   # Matching from 1 to 9
                        $                       # String end
                    /xi;
}

sub encode_roman {
    my $number = shift;
    my $roman;

    foreach my $r (sort { $roman_table{$b} <=> $roman_table{$a} } keys %roman_table) {
        my $d = int($number / $roman_table{$r});
        next unless $d;
        $roman .= $r x $d;
        $number -= $roman_table{$r} * $d;
        last unless $number;
    }

    return $roman;
}

sub decode_roman {
    my @roman = split //, shift;
    my $number;

    while (my $c1 = shift @roman) {
        my $c2 = @roman ? $roman[0] : 0;
        if (!$c2 || $roman_table{$c1} >= $roman_table{$c2} ) {
            $number += $roman_table{$c1};
        } else {
            $number += $roman_table{$c2} - $roman_table{$c1};
            shift @roman;
        }
    }

    return $number;
}

__END__
./ch-1.pl XI x II
XXII

./ch-1.pl XI - XI
Result cannot be expressed as a roman number: 0

./ch-1.pl XI . XI
Valid operations are: - / + x
