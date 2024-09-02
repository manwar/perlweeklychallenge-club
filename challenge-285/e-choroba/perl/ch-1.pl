#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub no_connection(@routes) {
    my %nodes;
    @nodes{ map @$_, @routes } = ();
    delete @nodes{ map $_->[0], @routes };
    return (keys %nodes)[0]
}

use Test::More tests => 2;

is no_connection(['B','C'], ['D','B'], ['C','A']), 'A', 'Example 1';
is no_connection(['A','Z']), 'Z', 'Example 2';
