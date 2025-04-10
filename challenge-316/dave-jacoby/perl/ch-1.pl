#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    [ "perl", "loves", "scala" ],
    [ "love", "the",   "programming" ],
    [ "java", "awk",   "kotlin", "node.js" ],
);

for my $example (@examples) {
    my $output = circular( $example->@* );
    my $list   = join ',', map { qq{"$_"} } $example->@*;
    say <<"END";
    Input:  \@list = ($list)
    Output: $output
END
}

sub circular (@list) {
    for my $i ( 1 .. $#list ) {
        my $first = ( substr $list[$i], 0, 1 );
        my $last = ( substr $list[$i-1], -1, 1 );
        return 'false' unless $first eq $last;
    }
    return 'true';
}
