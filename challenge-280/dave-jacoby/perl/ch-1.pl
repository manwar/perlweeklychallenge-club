#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

my @examples = (

    qw{
        acbddbca
        abccd
        abcdabbb
    },
);

for my $example (@examples) {
    my $output  = twice_appearance($example);
    say <<"END";
    Input:  \@str = "$example"
    Output: "$output"
END
}

sub twice_appearance ($input) {
    my $hash;
    for my $i ( split //, $input ) {
        $hash->{$i}++;
        return $i if $hash->{$i} > 1;

    }
    
    return '';
}
