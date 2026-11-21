#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-1.pl - Split Strings

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 253, Task 1: Split Strings.
Splits each string in an array by a given separator character and returns
all resulting non-empty words.

=head1 FUNCTIONS

=head2 split_strings($words, $separator)

Takes an array reference C<$words> of strings and a C<$separator> string.
Returns an array reference containing all non-empty substrings produced by
splitting each word on C<$separator>.

=cut

signature_for split_strings => (
    method     => 0,
    positional => [ ArrayRef[Str], Str ],
);

sub split_strings ( $words, $separator ) {
    my @result = grep { $_ ne '' } map { split /\Q$separator\E/, $_ } @$words;
    return \@result;
}

is_deeply(
    split_strings( [ 'one.two.three', 'four.five', 'six' ], '.' ),
    [ 'one', 'two', 'three', 'four', 'five', 'six' ],
    'Example 1: split on dot'
);
is_deeply(
    split_strings( [ '$perl$$', '$$raku$' ], '$' ),
    [ 'perl', 'raku' ],
    'Example 2: split on dollar sign'
);
is_deeply(
    split_strings( [ '...', '..' ], '.' ),
    [],
    'Edge case: all empty after splitting'
);
done_testing();
