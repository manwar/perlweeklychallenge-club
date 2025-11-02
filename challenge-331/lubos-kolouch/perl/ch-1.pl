#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 PURPOSE

Return the length of the final word in a string, ignoring any leading or
trailing whitespace. Words are sequences of non-whitespace characters.

=head1 ALGORITHM

We validate the argument with L<Type::Params> to ensure a defined string. The
string is scanned for word tokens using a regular expression; if at least one
word is found we report the length of the final token, otherwise we return zero.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub last_word_length ($text) {
    state $check = compile(Str);
    my ($str) = $check->($text);

    my @words = $str =~ /(\S+)/g;
    return @words ? length( $words[-1] ) : 0;
}

# Examples supplied by the specification.
is( last_word_length('The Weekly Challenge'), 9, 'Example 1' );
is( last_word_length('   Hello   World    '), 5, 'Example 2' );
is( last_word_length('Let\'s begin the fun'), 3, 'Example 3' );

done_testing();
