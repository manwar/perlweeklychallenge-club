#!/usr/bin/perl

use strict;
use warnings;

my $words  = [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ];
my $unique = shortest_unique_prefix($words);

print sprintf("[ %s ]\n", join(", ", @$unique));

sub shortest_unique_prefix {
    my ($words) = @_;

    my $p = [];
    foreach my $word (@$words) {
        my $i = 1;
        my $l = length($word);
        while ($i < $l) {
            my $char  = substr($word, 0, $i);
            my $count = scalar(grep { m/^$char/ } @$words);

            ($count > 1) && $i++ and next;
            push @$p, $char and last;
        }
    }

    return $p;
}
