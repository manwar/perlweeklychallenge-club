#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';

=pod

=head1 PURPOSE

Implementation for The Weekly Challenge 340, Task 1: remove adjacent duplicate
characters repeatedly until the string stabilises.

=head1 ALGORITHM

We walk the input string from left to right, using an array as a stack. Whenever
we encounter a character matching the current stack top, we pop the stack,
effectively discarding the duplicate pair. Otherwise, we push the character.
When the scan completes, the stack content is the fully reduced string.

=cut

sub duplicate_removals ($str) {
    _assert_plain_string($str);

    my @stack;
    for my $char ( split //, $str ) {
        if ( @stack && $stack[-1] eq $char ) {
            pop @stack;
        }
        else {
            push @stack, $char;
        }
    }

    return join q(), @stack;
}

sub _assert_plain_string ($value) {
    die 'Input must be a defined, non-reference string'
      if !defined $value || ref $value;
}

unless (caller) {
    require Test::More;
    Test::More->import( tests => 5 );

    Test::More::is( duplicate_removals('abbaca'),   'ca', 'Example 1' );
    Test::More::is( duplicate_removals('azxxzy'),   'ay', 'Example 2' );
    Test::More::is( duplicate_removals('aaaaaaaa'), q(),  'Example 3' );
    Test::More::is( duplicate_removals('aabccba'),  'a',  'Example 4' );
    Test::More::is( duplicate_removals('abcddcba'), q(),  'Example 5' );
}
