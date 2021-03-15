#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    if ( $ENV{TESTING} ) {
        test_match();
    }
    else {
        my ( $S, $P ) = @ARGV;
        die "usage: $0 STRING PATTERN\n" unless @ARGV == 2;

        say match( $S, $P ) ? 1 : 0;
    }
}

sub test_match() {

    my @test_cases = (
        [ "abcde", "a*e",   1 ],
        [ "abcde", "A*e",   0 ],
        [ "abcde", "a*d",   0 ],
        [ "abcde", "?b*d",  0 ],
        [ "abcde", "a*c?e", 1 ],
        [ "acde",  "a*c?e", 0 ],
    );

    require Test::More;
    Test::More->import( tests => scalar @test_cases );

    for my $test (@test_cases) {
        my ( $string, $pattern, $expected ) = @{$test};
        ok( match( $string, $pattern ) == $expected,
            "$string does " . ( $expected ? '' : 'not ' ) . "match $pattern" );
    }

}

# returns true if $string matches $pattern
# returns false otherwise
#
# The following characters have a special meaning in the pattern:
#  - ? - Match any single character.
#  - * - Match any sequence of characters.
#
# The pattern match is case sensitive.
sub match ( $string, $pattern ) {

    # we will transform the pattern into a regex and use perls internal regex
    # engine to perform the pattern matching for us.
    # first we quote non word chars in the user provided pattern to prevent
    # them from beeing interpreted as regex operators
    my $re = quotemeta($pattern);

    # then we convert that special chars into regex patterns.
    # a `?` in the pattern should match a single char. In a regex we do this
    # with a `.`. The `?` in the input has been prepended with a backslash by
    # quotemeta. So we have to replace that aswell.
    $re =~ s/\\\?/./g;

    # a `*` should match any sequence of chars. We do this by replacing each
    # `*` with a `.+` regex pattern
    $re =~ s/\\\*/.+/g;

    return $string =~ m/^$re$/;
}
