use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    return undef unless $string;
    my %occurences;
    for my $c (split //, $string) {
        $occurences{$c} += 1;
    }
    my @sorted = sort { $b <=> $a } values(%occurences);
    return $sorted[0] == 1 ? 1 : 0;
}

is(run("weekly"), 0, "Example 1");
is(run("perl"), 1, "Example 2");
is(run("challenge"), 0, "Example 3");
