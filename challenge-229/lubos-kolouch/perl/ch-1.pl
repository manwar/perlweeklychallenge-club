#!/usr/bin/perl

use strict;
use warnings;

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

my @str1 = ( "abc", "bce", "cae" );
print count_deletions(@str1), "\n";    # Output: 1

my @str2 = ( "yxz", "cba", "mon" );
print count_deletions(@str2), "\n";    # Output: 2
