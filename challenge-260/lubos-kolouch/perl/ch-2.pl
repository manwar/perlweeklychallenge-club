#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(product);
use Type::Params -sigs;
use Types::Standard qw(Int Str);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Dictionary Rank (The Weekly Challenge 260 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl GOOGLE
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a word, C<$word>.

Write a script to compute the dictionary rank of the given word (1-based
position among all distinct permutations of its letters sorted alphabetically).

=head1 FUNCTIONS

=head2 factorial($n)

Computes the factorial of a non-negative integer C<$n>.

=over 4

=item * C<$n> - Non-negative integer.

=back

Returns C<$n!>.

=head2 dictionary_rank($word)

Computes the 1-based lexicographical rank of C<$word> among all distinct
permutations of its characters.

=over 4

=item * C<$word> - Input string.

=back

Returns an integer representing the dictionary rank.

=cut

signature_for factorial => (
    method     => 0,
    positional => [Int],
);

sub factorial ($n) {
    return product( 1, 1 .. $n );
}

signature_for dictionary_rank => (
    method     => 0,
    positional => [Str],
);

sub dictionary_rank ($word) {
    my $length = length($word);
    my %char_counts;
    $char_counts{$_}++ for split //, $word;
    my $rank = 1;

    for my $i ( 0 .. $length - 1 ) {
        my $char          = substr( $word, $i, 1 );
        my $smaller_chars = 0;
        for my $candidate ( keys %char_counts ) {
            if ( $candidate lt $char ) {
                $smaller_chars += $char_counts{$candidate};
            }
        }

        my $denom = product( 1, map { factorial($_) } values %char_counts );
        $rank += $smaller_chars * factorial( $length - $i - 1 ) / $denom;

        $char_counts{$char}--;
        delete $char_counts{$char} if $char_counts{$char} == 0;
    }

    return $rank;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my ($word) = @args;
    my $result = dictionary_rank($word);
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            word     => 'CAT',
            expected => 3,
        },
        {
            label    => 'Example 2',
            word     => 'GOOGLE',
            expected => 88,
        },
        {
            label    => 'Example 3',
            word     => 'SECRET',
            expected => 255,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            dictionary_rank( $case->{word} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
