#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

die("Usage: $0 [--decrypt] <key>") unless @ARGV == 1 or @ARGV == 2;
die("Usage: $0 [--decrypt] <key>") unless @ARGV == 1 or $ARGV[0] eq '--decrypt';
die("Usage: $0 [--decrypt] <key>") unless $ARGV[-1] =~ m/^ [a-z]+ $/isx;

my $key     = $ARGV[-1];
my $decrypt = @ARGV == 2;

my (@keys) = map { ord($_) - ord('a') }
             split //, fc $key;

# Do we decrypt?
@keys = map { 26 - $_ } @keys if $decrypt;

my @input;
while ( my $line = <stdin> ) { push @input, split( //, $line ) }

foreach my $c (@input) {
    my $offset = $keys[0];

    if ( $c =~ m/ [a-z] /x ) {
        push @keys, shift @keys;    # Circular buffer
        my $new = ord($c) + $offset;
        $new -= 26 if $new > ord('z');
        print chr($new);
    } elsif ( $c =~ m/ [A-Z] /x ) {
        push @keys, shift @keys;    # Circular buffer
        my $new = ord($c) + $offset;
        $new -= 26 if $new > ord('Z');
        print chr($new);
    } else {
        print $c;
    }
}

