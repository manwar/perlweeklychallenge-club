#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int Str);
use Test::More;

=head1 NAME

ch-1.pl - Sort Language

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 245, Task 1: Sort Language.
Given an array of programming languages and a corresponding array of
popularity rankings, returns the languages sorted in ascending order of
popularity.

=head1 FUNCTIONS

=head2 sort_language($langs, $popularity)

Returns an array reference of languages ordered by their corresponding
popularity values in C<$popularity>.

=cut

signature_for sort_language => (
    method     => 0,
    positional => [ ArrayRef [Str], ArrayRef [Int] ],
);

sub sort_language ( $langs, $popularity ) {
    return [
        map  { $_->[0] }
        sort { $a->[1] <=> $b->[1] }
        map  { [ $langs->[$_], $popularity->[$_] ] } 0 .. $#$langs
    ];
}

is_deeply(
    sort_language( [ 'perl', 'c', 'python' ], [ 2, 1, 3 ] ),
    [ 'c', 'perl', 'python' ],
    'Example 1'
);
is_deeply(
    sort_language( [ 'c++', 'haskell', 'java' ], [ 1, 3, 2 ] ),
    [ 'c++', 'java', 'haskell' ],
    'Example 2'
);
done_testing();
