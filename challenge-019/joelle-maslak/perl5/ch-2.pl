#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

my $col = int( $ARGV[0] // 0 );
die "Provide column on which to wrap" unless $col;
die "Too many arguments provided" unless scalar(@ARGV) == 1;

my @lines;
while ( my $line = <stdin> ) { push @lines, $line }

my (@words) = split /\s+/, join( "", @lines );

my $line = '';
for my $word (@words) {
    if ( length($line) + length($word) + 1 > $col ) {
        say $line;
        $line = '';

        if ( length($word) > $col ) {
            die("Words must be <= $col columns long to be wrapped at column $col");
        }
    }
    $line .= ' ' unless length($line) == 0;
    $line .= $word;
}
say $line unless length($line) == 0;

