#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

my @digit = qw( abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg );
my @segments = (['a'], (['f', 'b']) x 2, ['g'], (['e', 'c']) x 2, ['d']);

# Char 1, length, count of spaces in between, char 2, length.
my %line = (1 => ['-', 7, 0, "", 0],
            2 => ['|', 1, 5, '|', 1]);

sub draw($number) {
    my @digits = map $digit[$_], split //, $number;
    for my $s (@segments) {
        for my $digit (@digits) {
            my $type = scalar @$s;
            print join ' ' x $line{$type}[2],
                map +(
                         (-1 == index $digit, $s->[$_] // "")
                         ? ' '
                         : $line{$type}[ 3 * $_ ]
                     ) x $line{$type}[ 3 * $_ + 1 ],
                0, 1;
            print '  ';
        }
        print "\n";
    }
}

draw(join "", 0 .. 9);
draw(200);
