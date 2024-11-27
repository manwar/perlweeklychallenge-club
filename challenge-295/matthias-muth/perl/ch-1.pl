#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 295 Task 1: Word Break
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub word_break( $str, $words ) {
    my $pattern = join "|", $words->@*;
    return $str =~ /^($pattern)+$/;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

ok word_break( "weeklychallenge", ["challenge", "weekly"] ),
    'Example 1: word_break( "weeklychallenge", ["challenge", "weekly"] ) is true';
ok word_break( "perlrakuperl", ["raku", "perl"] ),
    'Example 2: word_break( "perlrakuperl", ["raku", "perl"] ) is true';
ok ! word_break( "sonsanddaughters", ["sons", "sand", "daughters"] ),
    'Example 3: word_break( "sonsanddaughters", ["sons", "sand", "daughters"] ) is false';

done_testing;
