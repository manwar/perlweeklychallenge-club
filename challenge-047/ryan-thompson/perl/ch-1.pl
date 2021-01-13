#!/usr/bin/env perl
#
# ch-1.pl - Roman calculator
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw<sum first>;
use Test::More;

my %rom = (I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000,
                  IV => 4,IX =>  9,XL => 40,XC =>  90,CD => 400,CM =>  900);
my @mor = map { [ $rom{$_} => $_ ] } sort { $rom{$b} <=> $rom{$a} } keys %rom;

say roman_expr(join ' ', @ARGV) and exit if @ARGV;

# Perform arbitrary expressions using Roman numerals
sub roman_expr {
    my $expr = shift;
    $expr =~ s/\b([IVXLCDM]+)\b/roman_to_arabic($1)/eg;
    die "Invalid expression" if $expr =~ m![^ 0-9+*%/()-]!;

    arabic_to_roman( eval $expr );
}

sub roman_to_arabic {
    sum map { $rom{$_} } pop =~ /(I[VX]|X[LC]|C[DM]|[IVXLCDM])/g 
}

sub arabic_to_roman {
    my $n = shift;
    my $r = '';
    while ($n) {
        my ($val, $rom) = @{( first { $_->[0] <= $n } @mor )};
        $n -= $val;
        $r .= $rom;
    }
    $r;
}

#
# Testing code
#
my %tests = (
    I           => 1,
    XXXIX       => 39,
    CLX         => 160,
    CCXXXVII    => 237,
    CDXXXVIII   => 438,
    DCCCXLVIII  => 848,
    MLXVI       => 1066,
    MM          => 2000,
    MMXX        => 2020,
);
my @order = sort { $tests{$a} <=> $tests{$b} } keys %tests;

is roman_to_arabic($_), $tests{$_}, "$_ => $tests{$_}" for @order;
is arabic_to_roman($tests{$_}), $_, "$tests{$_} => $_" for @order;

my %expr = (
    XL      => 'XXXIX + I',
    DCLXXV  => 'CCXXXVII + CDXXXVIII',
    XIV     => '(CCXXXVII + CDXXXVIII) % XIII ** II / XII',
);
is roman_expr($expr{$_}), $_, "$_ = $expr{$_}" for sort keys %expr;

done_testing;
