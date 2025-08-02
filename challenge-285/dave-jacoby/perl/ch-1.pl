#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ postderef say signatures state };

use List::Util qw{ uniq };

my @examples = (    # added a couple test entries

    [ [ 'B', 'C' ], [ 'D', 'B' ], [ 'C', 'A' ] ],
    [ [ 'A', 'Z' ] ],

);

for my $example (@examples) {
    my $routes = join ', ', map { qq{[$_]} }
        map {
        join ',',
            map { qq{"$_"} }
            $_->@*
        } $example->@*;
    my $output = no_connection($example);
    say <<"END";
    Input:  \@routes = ($routes)
    Output: "$output"
END
}

sub no_connection ($input) {
    my %routes;
    map { $routes{ $_->[0] } = $_->[1] } $input->@*;
    for my $k ( keys %routes ) {
        no warnings;
        if ( defined $routes{ $routes{$k} } ) {
            my $v  = $routes{$k};
            my $vv = $routes{$v};
            $routes{$k} = $vv;
            delete $routes{$v};
        }
    }
    my ($k) = keys %routes;
    return $routes{$k};
}
