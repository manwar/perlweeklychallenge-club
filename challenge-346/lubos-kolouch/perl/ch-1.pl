#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(StrMatch);
use Test::More;

=pod

=head1 PURPOSE

Compute the length of the longest valid parenthesis substring contained in
an input string made up exclusively of opening and closing parentheses.

=head1 ALGORITHM

We validate the input using L<Type::Params> to ensure it only contains the
characters C<(>) and C<)>. A stack of indices tracks unmatched opening
parentheses, seeded with C<-1> as a sentinel to simplify length
calculations. While scanning the string:

=over 4

=item *
Push the index of every opening parenthesis.

=item *
Pop for each closing parenthesis, measuring the span back to the previous
unmatched position. When the stack empties we push the current index to mark
the start of the next candidate segment.

=back

The maximum span observed is the required result.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub longest_parenthesis ($str_input) {
    state $check = compile( StrMatch [qr/\A[()]*\z/] );
    my ($str) = $check->($str_input);

    my $length = length $str;
    return 0 if $length == 0;

    my @stack   = (-1);
    my $longest = 0;

    for my $idx ( 0 .. $length - 1 ) {
        my $char = substr $str, $idx, 1;

        if ( $char eq '(' ) {
            push @stack, $idx;
            next;
        }

        pop @stack;
        if (@stack) {
            my $candidate = $idx - $stack[-1];
            $longest = $candidate if $candidate > $longest;
        }
        else {
            push @stack, $idx;
        }
    }

    return $longest;
}

# Example tests provided by the specification.
is( longest_parenthesis('(()())'),        6, 'Example 1' );
is( longest_parenthesis(')()())'),        4, 'Example 2' );
is( longest_parenthesis('((()))()(((()'), 8, 'Example 3' );
is( longest_parenthesis('))))((()('),     2, 'Example 4' );
is( longest_parenthesis('()(()'),         2, 'Example 5' );

done_testing();
