#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = ( [ "adc", "wzy", "abc" ], [ "aaa", "bob", "ccc", "ddd" ] );

my @alphabet = 'a' .. 'z';
my $c        = 0;
my %l2n      = map { $_ => $c++ } @alphabet;

for my $e (@examples) {
    my $output  = odd_string( $e->@* );
    my $example = join ', ', map { qq{"$_"} } $e->@*;
    say <<"END";
    Input:  \@s =  ($example)
    Output: "$output"
END
}

sub odd_string ( @words ) {
    my %results;
    for my $word (@words) {
        my @values;
        for my $i ( 1 .. -1 + length $word ) {
            my $l1 = substr $word, $i, 1;
            my $l2 = substr $word, $i - 1, 1;
            my $n1 = $l2n{$l1};
            my $n2 = $l2n{$l2};
            my $v  = $n1 - $n2;
            push @values, $v;
        }
        my $string = join ', ', @values;
        push $results{$string}->@*, $word;
    }
    for my $k ( keys %results ) {
        my @v = $results{$k}->@*;
        if ( 1 == scalar @v ) {
            return $v[0];
        }
    }
    return -1;
}
