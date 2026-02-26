#!/usr/bin/env perl

# You are given an array of integers.

# Write a script to return them in alphabetical order,
# in any language of your choosing. Default language is English.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

my %nums = (
             0    => 'zero',
             1    => 'one',
             2    => 'two',
             3    => 'three',
             4    => 'four',
             5    => 'five',
             6    => 'six',
             7    => 'seven',
             8    => 'eight',
             9    => 'nine',
             10   => 'ten',
             11   => 'eleven',
             12   => 'twelve',
             13   => 'thirteen',
             14   => 'fourteen',
             15   => 'fifteen',
             16   => 'sixteen',
             17   => 'seventeen',
             18   => 'eighteen',
             19   => 'nineteen',
             20   => 'twenty',
             30   => 'thirty',
             40   => 'forty',
             50   => 'fifty',
             60   => 'sixty',
             70   => 'seventy',
             80   => 'eighty',
             90   => 'ninety',
             100  => 'one hundred',
             200  => 'two hundred',
             300  => 'three hundred',
             400  => 'four hundred',
             500  => 'five hundred',
             600  => 'six hundred',
             700  => 'seven hundred',
             800  => 'eight hundred',
             900  => 'nine hundred',
             1000 => 'one thousand'
           );

my @nums = ( sort { $b <=> $a } keys %nums );

sub num_to_words {
    my $n     = shift;
    my $debug = 0;
    my $words = '';

    foreach my $num (@nums) {
        if ( $n < 0 ) {
            $words .= 'minus ';
            $n = abs($n);
        }
        if ( $n == $num ) {
            $words .= $nums{ $num };
            print $nums{ $num } . "\n" if ($debug);
            last;
        }
        if ( $n - $num > 0 ) {
            $words .= $nums{ $num };
            $n -= $num;
            print $nums{ $num } . "\t" if ($debug);
            if ( $num > 99 ) {
                $words .= ' and ';
                print "and\t" if ($debug);
                next;
            }
            if ( $num > 19 ) {
                $words .= '-';
                print "-\t" if ($debug);
            }
        }
    }
    return ($words);
}

sub spellbound_sorting {
    my @inputs = @{ $_[0] };
    say 'Input: (' . join( ', ', @inputs ) . q{)};

    my @results = sort { num_to_words($a) cmp num_to_words($b) } @inputs;

    say 'Output: (' . join( ', ', @results ) . q{)};
    return \@results;
}

my @examples = (
                 {  in   => [ 6, 7, 8, 9, 10 ],
                    out  => [ 8, 9, 7, 6, 10 ],
                    name => 'example 1'
                 },
                 {  in   => [ -3, 0,  1000, 99 ],
                    out  => [ -3, 99, 1000, 0 ],
                    name => 'example 2'
                 },
                 {  in   => [ 1, 2, 3, 4, 5 ],
                    out  => [ 5, 4, 1, 3, 2 ],
                    name => 'example 3'
                 },
                 {  in   => [  0, -1, -2, -3, -4 ],
                    out  => [ -4, -1, -3, -2,  0 ],
                    name => 'example 4'
                 },
                 {  in   => [ 100, 101, 102 ],
                    out  => [ 100, 101, 102 ],
                    name => 'example 5'
                 },
               );

is( spellbound_sorting( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

