#!/usr/bin/env perl

# Perl Weekly Challenge 227 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/

use Modern::Perl;

my @roman_table = (
    ["M", 1000],
    ["CM", 900],
    ["D", 500],
    ["CD", 400],
    ["C", 100],
    ["XC", 90],
    ["L", 50],
    ["XL", 40],
    ["X", 10],
    ["IX", 9],
    ["V", 5],
    ["IV", 4],
    ["I", 1],
);

my $roman_re = qr/[IVXLCDM]+/;
my $op_re = qr/\*\*|[-+*\/]/;

my $expr = "@ARGV";
$expr =~ /^\s*($roman_re)\s*($op_re)\s*($roman_re)\s*$/ or die "invalid expression\n";
my($a, $op, $b) = ($1, $2, $3);
$a = decode_roman($a);
$b = decode_roman($b);
my $num_expr = "$a $op $b";
my $result = eval($num_expr);
$@ and die "$num_expr: $@";

if ($result == 0) {
    say "nulla";
}
elsif (int($result) != $result) {
    say "non potest";
}
elsif ($result < 0) {
    say "non potest";
}
elsif ($result > 3999) {
    say "non potest";
}
else {
    say encode_roman($result);
}

sub decode_roman {
    my($roman) = @_;
    my $value = 0;
DIGIT:
    while ($roman ne '') {
        for (@roman_table) {
            my($t, $v) = @$_;
            if ($roman =~ s/^$t//) {
                $value += $v;
                next DIGIT;
            }
        }
        die $roman; # invalid roman
    }
    return $value;
}

sub encode_roman {
    my($value) = @_;
    if ($value < 0 || $value > 3999 || int($value) != $value) {
        return "non potesta";
    }
    elsif ($value == 0) {
        return "nulla";
    }
    else {
        my $roman = "";
    DIGIT:
        while ($value > 0) {
            for (@roman_table) {
                my($t, $v) = @$_;
                if ($value >= $v) {
                    my $n = int($value / $v);
                    $value -= $n * $v;
                    $roman .= $t x $n;
                    next DIGIT;
                }
            }
            die $value; # bug
        }
        return $roman;
    }
}
