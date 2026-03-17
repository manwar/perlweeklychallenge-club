#!/usr/bin/env perl

# Perl Weekly Challenge 245 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

use Modern::Perl;

sub largest {
    my($prefix, @nums) = @_;

    my $largest = -1;
    $prefix =~ s/^0+(\d)/$1/;
    if (length($prefix) > 0) {
        if ($prefix % 3 == 0) {
            $largest = $prefix if $prefix > $largest;
        }
    }

    for my $i (0 .. $#nums) {
        my $new = largest($prefix.$nums[$i],
                          @nums[0..$i-1], @nums[$i+1..$#nums]);
        $largest = $new if $new > $largest;
    }

    return $largest;
}

@ARGV or die "Usage: $0 n n n...\n";
my @nums = @ARGV;
say largest('', @nums);
