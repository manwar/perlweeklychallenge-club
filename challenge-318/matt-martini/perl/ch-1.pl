#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use Test2::V0;
use Data::Dumper;

plan tests => 3;

$Data::Dumper::Indent = 3;    # pretty print with array indices

sub group_pos {
    my ( $str, $result_ref ) = @_;

    print "$str\n";

    while ( $str =~ m|(.)|g ) {
        my $mc = $1;
        if ( $str =~ m|($mc{3,})| ) {
            print $1 . "\n";
        }
    }

    # print Dumper \@result;
    return 1;
}

is( group_pos( 'abccccd',        ['cccc'] ),                 1, 'example 1' );
is( group_pos( 'aaabcddddeefff', [ 'aaa', 'dddd', 'fff' ] ), 1, 'example 2' );
is( group_pos( 'abcdd',          [''] ),                     1, 'example 3' );
