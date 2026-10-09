#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first };

sub alternate_case($str) {
    $str =~ tr/a-zA-Z/0000000000000000000000000011111111111111111111111111/;
    my $min = length $str;
    for my $s (map $_ x (length($str) / 2), '01', '10') {
        my @r;
        for my $pos (0 .. length($str) - 1) {
            push @r, substr($str, $pos, 1) cmp substr($s, $pos, 1);
        }
        my $swaps = 0;
        for my $i (0 .. $#r - 1) {
            next if 0 == $r[$i];

            my $j = first { $r[$_] && $r[$_] != $r[$i] } $i + 1 .. $#r;
            $swaps += $j - $i;
            $r[$_] = 0 for $i, $j;
        }
        $min = $swaps if $swaps < $min;
    }
    return $min
}

sub alternate_case_naive($str) {
    $str =~ tr/a-zA-Z/0000000000000000000000000011111111111111111111111111/;
    return 0 if $str !~ /(.)\1/;

    my $tally = 0;
    my %agenda = ($str => undef);
    while (1) {
        ++$tally;
        my %next;
        for my $pos (1 .. length $str) {
            for my $s (keys %agenda) {
                substr $s, $pos -1, 2, reverse substr $s, $pos - 1, 2;
                return $tally if $s !~ /(.)\1/;

                undef $next{$s};
            }
        }
        %agenda = %next;
    }
}

use Test::More tests => 2 * (5 + 2) + 1;

my %F = (naive => \&alternate_case_naive,
         opt   => \&alternate_case);

for my $f (keys %F) {
    is $F{$f}('aAbB'), 0, "Example 1 $f";
    is $F{$f}('AAbb'), 1, "Example 2 $f";
    is $F{$f}('AAAbbb'), 3, "Example 3 $f";
    is $F{$f}('aABb'), 1, "Example 4 $f";
    is $F{$f}('bBBAaa'), 2, "Example 5 $f";

    is $F{$f}(""), 0, "Empty string $f";
    is $F{$f}('Ab'), 0, "Two chars $f";
}

my $long = 'AAAaAaaaAa';
is alternate_case($long), alternate_case_naive($long), "same $long";

use Benchmark qw{ cmpthese };

cmpthese(-3, {
    naive => sub { alternate_case_naive($long) },
    opt   => sub { alternate_case($long) },
});

__END__
         Rate naive   opt
naive  2146/s    --  -96%
opt   56523/s 2534%    --
