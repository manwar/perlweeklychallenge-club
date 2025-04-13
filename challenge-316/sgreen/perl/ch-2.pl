#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $str1, $str2 ) {
    my $r         = join( '.*', map { quotemeta } split //, $str1 );
    my $is_subseq = $str2 =~ $r;
    say $is_subseq ? 'true' : 'false';
}

main( $ARGV[0], $ARGV[1] );
