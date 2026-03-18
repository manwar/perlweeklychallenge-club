#!/usr/bin/env perl

# Perl Weekly Challenge 352 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/

use Modern::Perl;

@ARGV or die "usage: $0 1 0 1 0...\n";

my @result = map {$_ ? 'true' : 'false'}
             map {$_ % 5 == 0} prefix_bin(@ARGV);
say join ", ", @result;

sub prefix_bin {
    my(@digits) = @_;
    my @values;
    for my $i (0 .. $#digits) {
        my $str = "0b".join("", @digits[0..$i]);
        my $value = eval($str);
        $@ and dir $@;
        push @values, $value;
    }
    return @values;
}
