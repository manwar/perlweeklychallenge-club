#!/usr/bin/perl
use strict;
use warnings;

sub generate_eban_numbers {
    my $limit = shift;

    my %words = (
        1   => 'one',
        2   => 'two',
        3   => 'three',
        4   => 'four',
        5   => 'five',
        6   => 'six',
        7   => 'seven',
        8   => 'eight',
        9   => 'nine',
        10  => 'ten',
        11  => 'eleven',
        12  => 'twelve',
        13  => 'thirteen',
        14  => 'fourteen',
        15  => 'fifteen',
        16  => 'sixteen',
        17  => 'seventeen',
        18  => 'eighteen',
        19  => 'nineteen',
        20  => 'twenty',
        30  => 'thirty',
        40  => 'forty',
        50  => 'fifty',
        60  => 'sixty',
        70  => 'seventy',
        80  => 'eighty',
        90  => 'ninety',
        100 => 'one hundred'
    );

    my @eban_numbers;
    for my $num ( 1 .. $limit ) {
        my $word;
        if ( $num <= 20 || $num == 100 ) {
            $word = $words{$num};
        }
        elsif ( $num < 100 ) {
            $word = $words{ int( $num / 10 ) * 10 } . " " . $words{ $num % 10 };
        }
        else {
            $word =
                $words{ int( $num / 100 ) } . " "
              . $words{100} . " "
              . $words{ $num % 100 };
        }

        if ( $word !~ /e/ ) {
            push @eban_numbers, $num;
        }
    }

    return @eban_numbers;
}

print join( ", ", generate_eban_numbers(100) );
