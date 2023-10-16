#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    {
        str     => [ "ad", "bd", "aaab", "baa", "badab" ],
        allowed => "ab"
    },
    {
        str     => [ "a", "b", "c", "ab", "ac", "bc", "abc" ],
        allowed => "abc"
    },
    {
        str     => [ "cc", "acd", "b", "ba", "bac", "bad", "ac", "d" ],
        allowed => "cad"
    },
);

for my $e (@examples) {
    my $output  = consistent_strings($e);
    my $str     = join ', ', map { qq{"$_"} } $e->{str}->@*;
my $allowed = $e->{allowed};
    say <<~"END";
    Input:  \@str = ($str)
            \$allowed = "$allowed"
    Output: $output
    END
}

sub consistent_strings ($input) {
    my @allowed = split //, $input->{allowed};
    my %allowed = map { $_ => 1 } @allowed;
    my $n       = 0;
OUTER: for my $str ( $input->{str}->@* ) {
        my @chars = uniq sort split //, $str;
        for my $c (@chars) {
            next OUTER if !$allowed{$c};
        }
        $n++;
    }
    return $n;
}

