#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    {
        str => 'ABC-D-E-F',
        i   => 3,
    },
    {
        str => 'A-BC-D-E',
        i   => 2,
    },
    {
        str => '-A-BC-DE',
        i   => 4,
    },
);

for my $example (@examples) {
    my $output = string_format($example);
    say <<"END";
    Input:  \$str = "$example->{str}"
            \$i   = $example->{i}
    Output: $output
END
}

sub string_format ($obj) {
    my $i   = $obj->{i};
    my $str = $obj->{str};
    $str = substr( $str, 1 ) while $str =~ /^-/mx;
    my $l = length $str;
    for my $x ( reverse 0 .. $l ) {
        my $c = substr( $str, $x, 1 );
        next if $c =~ /\w/mx;
        next if $x + 1 >= $l;
        my $group = substr( $str, $x + 1 );
        ($group) = split /-/, $group;
        if ( length $group < $i ) {
            substr( $str, $x, 1 ) = '';
        }
    }
    return $str;
}
