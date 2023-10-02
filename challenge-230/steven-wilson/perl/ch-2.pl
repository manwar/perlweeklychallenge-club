#!/usr/bin/env perl

use 5.12.0;
use Test2::V0 -no_srand;

my @t1_words  = ( "pay", "attention", "practice", "attend" );
my $t1_prefix = "at";
my @t2_words  = ( "janet", "julia", "java", "javascript" );
my $t2_prefix = "ja";
is( count_words_with_prefix( $t1_prefix, @t1_words ), 2, "Example 1" );
is( count_words_with_prefix( $t2_prefix, @t2_words ), 3, "Example 2" );
done_testing();

sub count_words_with_prefix {
    my ( $prefix, @words ) = @_;
    my $count = grep { ( index $_, $prefix ) == 0 } @words;
    return $count;
}
