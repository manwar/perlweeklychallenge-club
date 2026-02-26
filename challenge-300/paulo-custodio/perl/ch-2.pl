#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums...\n";

my @nested = nested(@ARGV);
my @length = map {scalar(@$_)} @nested;
say max(@length);

sub nested {
    my(@nums) = @_;
    my @nested;
    for my $i (0 .. $#nums) {
        my %seen;
        my @seq;
        my $idx = $i;
        while (1) {
            my $next = $nums[$idx];
            last if $seen{$next}++;
            push @seq, $next;
            $idx = $next;
        }
        push @nested, \@seq;
    }
    return @nested;
}
