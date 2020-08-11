#!/usr/bin/perl
use strict;
use warnings;

# Usage: ch-2.pl [digit string]

my $INPUT = '35';

$INPUT = $ARGV[0] if $ARGV[0];

my %BOARD = ('2', [qw/A B C/], '3', [qw/D E F/], '4', [qw/G H I/], 
             '5', [qw/J K L/], '6', [qw/M N O/], '7', [qw/P Q R S/],
             '8', [qw/T U V/], '9', [qw/W X Y Z/]
            );

my @input_str = split //, $INPUT;

my @ans = ( "" );

for my $d (@input_str) {
    my @prev_ans = @ans;
    @ans = ();
    for my $s_str (@prev_ans) {
        for my $ch (@{$BOARD{$d}}) {
            push @ans, $s_str."\l$ch";
        }
    }
}

print join ", ", @ans;
print "\n";
