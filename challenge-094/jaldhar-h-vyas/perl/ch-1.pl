#!/usr/bin/perl
use 5.40.1;
use warnings;

my @S = @ARGV;

my %words;
for my $word (@S) {
    push @{$words{join q{}, sort split //, $word}}, $word;
}

say
    q{[ },
    (
        join ",\n",
        map { q{(} . ( join q{, }, map { "\"$_\"" } @{$_} ) . q{)} }
        grep { scalar @S == 1 || scalar @{$_} > 1 }
        values
        %words
    ),
    q{ ]};
