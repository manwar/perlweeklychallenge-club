#!/usr/bin/perl
use 5.40.1;
use warnings;

my $str = shift;
my @results;

for my $match ($str =~ /([aeiou]+)/g) {
    my $len = length $match;
    for my $start (0 .. $len - 5) {
        for my $end ($start + 5 .. $len) {
            my $substring = substr $match, $start, $end - $start;
            if ($substring =~ /(?=.*a)(?=.*e)(?=.*i)(?=.*o)(?=.*u)/) {
                push @results, $substring;
            }
        }
    }
}

say q{(}, (join q{, }, map { "\"$_\"" } @results), q{)};
