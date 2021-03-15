#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 };

use JSON;
my $json = JSON->new->pretty->canonical;

my $n      = 4;
my $flag   = 0;
my @inputs = qw{ twinkie input1.txt input2.txt };
while ( $flag < @inputs ) {
    state $flags;
    for my $input (@inputs) {
        my $output = readN( $input, $n );
        do {
            $flags->{$input} = 1;
            $flag = sum0 values %$flags;
            next;
        } if $output eq '';
        say qq{\t'$input'\t$n\t'$output'};
    }
}
exit;

# returns empty string on failure cases, which include
#   * no file
#   * index beyond file length

sub readN ( $file, $chars ) {
    state $fhs;
    return '' unless -f $file;
    return '' unless -r $file;
    unless ( $fhs->{$file} ) { open $fhs->{$file}, '<', $file }

    my $fh = $fhs->{$file};
    my $output ;
    read $fh, $output, $chars;
    return $output;
}

