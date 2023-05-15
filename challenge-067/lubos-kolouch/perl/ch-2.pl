#!/usr/bin/perl
use strict;
use warnings;

sub letter_combinations {
    my ($s) = @_;
    my %phone = (
        '2' => ['a', 'b', 'c'],
        '3' => ['d', 'e', 'f'],
        '4' => ['g', 'h', 'i'],
        '5' => ['j', 'k', 'l'],
        '6' => ['m', 'n', 'o'],
        '7' => ['p', 'q', 'r', 's'],
        '8' => ['t', 'u', 'v'],
        '9' => ['w', 'x', 'y', 'z'],
    );

    my @result = ('');

    for my $digit (split //, $s) {
        my @new_result;
        for my $res (@result) {
            for my $letter (@{$phone{$digit}}) {
                push @new_result, $res . $letter;
            }
        }
        @result = @new_result;
    }

    return \@result;
}

my $s = '35';
my $combinations = letter_combinations($s);
print "[", join(", ", map { "\"$_\"" } @$combinations), "]\n";

