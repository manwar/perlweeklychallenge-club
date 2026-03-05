#!/usr/bin/env perl

use Modern::Perl;

my($sentence, $keys) = split /,/, "@ARGV";
my @words = split ' ', $sentence;
my @keys = split ' ', $keys;

say scalar grep {can_type($_, @keys)} @words;

sub can_type {
    my($word, @keys) = @_;
    for my $ch (@keys) {
        return 0 if $word =~ /$ch/i;
    }
    return 1;
}
