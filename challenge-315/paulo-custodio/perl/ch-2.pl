#!/usr/bin/env perl

use Modern::Perl;

my @words = split /\W+/, <>;
chomp(my $first = <>);
chomp(my $second = <>);

say "(", join(", ", find_third($first, $second, @words)), ")";

sub find_third {
    my($first, $second, @words) = @_;
    my @third;
    for my $i (0 .. $#words-2) {
        if ($words[$i] eq $first && $words[$i+1] eq $second) {
            push @third, $words[$i+2];
        }
    }
    return @third;
}
