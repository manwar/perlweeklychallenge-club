#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util      qw( uniq );
use List::MoreUtils qw( first_index );

my @examples = (

    [ "java",  "javascript", "julia" ],
    [ "bella", "label",      "roller" ],
    [ "cool",  "lock",       "cook" ],
    [qw{ pizza prince pepper pauper }],
);

for my $e (@examples) {
    my @words = $e->@*;
    my $words = join ', ', map { qq{"$_"} } @words;
    my @output = common_chars(@words);
    my $output = join ', ', map { qq{"$_"} } @output;
    say <<~"END";
    Input:  \@words = ($words)
    Output: ($output)
    END
}

sub common_chars (@words) {
    @words = map { join '', sort split //, $_ } @words;
    my $done = 0;
    my @common;

    my $c = 0;
OUTER: while (1) {
        my $test = scalar uniq sort map { substr $_, 0, 1 } @words;
        $c++;
        if ( $test == 1 ) {
            push @common, substr( $words[0], 0, 1 );
            map { substr( $_, 0, 1 ) = '' } @words;
            next OUTER;
        }
        else {
            my @first   = grep { /\w/ } map { substr $_, 0, 1 } @words;
            my ($first) = sort @first;
            my $fi      = first_index { $_ eq $first } @first;
            substr( $words[$fi], 0, 1 ) = '';
        }
        last OUTER if $c > 20;
    }
    return @common;
}
