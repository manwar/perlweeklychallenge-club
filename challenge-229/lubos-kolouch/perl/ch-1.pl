#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

sub count_deletions {
    my @str   = @_;
    my $count = 0;
    for my $s (@str) {
        if ( $s ne join( '', sort split //, $s ) && $s ne join( '', reverse sort split //, $s ) ) {
            $count++;
        }
    }
    return $count;
}

# Test cases
is( count_deletions( "abc", "bce", "cae" ), 1, 'Example 1' );
is( count_deletions( "yxz", "cba", "mon" ), 2, 'Example 2' );

done_testing();
