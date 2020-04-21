#!/usr/bin/env perl
use Modern::Perl;

my @words = qw/alphabet book carpet cadmium cadeau alpine/;

my @prefixes;

for my $word (@words) {
    my $length;
    my $prefix;
    my @rest = @words;

    do {
        $length++;
        $prefix = substr($word, 0, $length); 
        @rest = grep { /^$prefix/ } @rest; 
    } while @rest > 1;

    push (@prefixes, $prefix);
}

say join(", ", @prefixes);
