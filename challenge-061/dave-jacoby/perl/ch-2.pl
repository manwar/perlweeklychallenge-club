#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

my $input = '25525511135';
($input) = $ARGV[0] =~ /(\d+)/ if defined $ARGV[0];
my @input  = split //, $input;
my $output = '';

say join "\n\t", "$input =>", ipv4_partitions( $output, @input );

sub ipv4_partitions ( $output, @input ) {
    return if $output =~ /^\./;
    return if 4 < scalar split /\./, $output;
    return if grep { int $_ > 255 } split /\./, $output;
    return if grep { length $_ > 3 } split /\./, $output;
    return if grep { $_ =~ /0\d/ } split /\./, $output;
    my @zed;

    if ( scalar @input ) {
        my $next = shift @input;
        push @zed, ipv4_partitions( qq{$output\.$next}, @input );
        push @zed, ipv4_partitions( qq{$output$next},   @input );
    }
    else {
        return if 4 != scalar split /\./, $output;
        push @zed, $output;
    }
    return @zed;
}

