#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{say signatures };
no warnings qw{experimental};

my @arr;
push @arr, [ 'abcde', 'a*e' ];
push @arr, [ 'abcde', 'a*d' ];
push @arr, [ 'abcde', '?b*d' ];
push @arr, [ 'abcde', 'a?c*e' ];

for my $n (@arr) {
    my $p = pattern_match( $n->@* );
    say $n->[0];
    say $n->[1];
    say $p;
}

sub pattern_match ( $S, $P ) {
    my $pattern = $P;

    # this was my first pass on this part
    # $pattern =~ s/\*/.*/g;
    # $pattern =~ s/\?/.?/g;  
    #
    # a comment from Jonas Berlin (xkr47) 
    # made me reconsider. By the rules of the
    # task, ? is ONE character and * is MANY 
    # CHARACTERS, but in Perl's regular 
    # expressions, .? is ZERO OR ONE CHARACTER
    # and .* is ZERO OR MORE CHARACTERS
    # to get ONE OR MORE CHARACTERS, we instead
    # use .+ and to get ONE CHARACTER, we use .
    # 
    # but of course, we need to match the WHOLE
    # string, so we're matching the beginning (^)
    # and the end ($)

    $pattern =~ s/\*/.+/g;
    $pattern =~ s/\?/./g;  
    $pattern = qq{^$pattern\$};
    return $S =~ /$pattern/mix ? 1 : 0;
}

