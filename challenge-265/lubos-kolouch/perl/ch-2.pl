#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Completing Word (The Weekly Challenge 265 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl "aBc 11c" accbbb abc abbc
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a string, C<$str>, and an array of strings, C<@words>.

Write a script to find the shortest completing word in the given array of strings.
A completing word is a word that contains all the letters in the given string
(ignoring case and numbers/special characters). If a letter appears more than once
in the given string, then it must appear that many times or more in the completing word.
If there are multiple shortest completing words, return the first one that occurs in the array.
If no completing word is found, return an empty string.

=head1 FUNCTIONS

=head2 shortest_completing_word($target, $words)

Finds the shortest completing word from C<$words> matching C<$target>.

=over 4

=item * C<$target> - Target string containing required letters.

=item * C<$words> - Reference to an array of candidate words.

=back

Returns the shortest completing word, or an empty string if none found.

=cut

signature_for shortest_completing_word => (
    method     => 0,
    positional => [ Str, ArrayRef [Str] ],
);

sub _get_letter_counts ($s) {
    my %counts;
    for my $char ( split //, lc $s ) {
        if ( $char =~ /^[a-z]$/ ) {
            $counts{$char}++;
        }
    }
    return \%counts;
}

sub _is_completing ( $target_count, $word ) {
    my $word_count = _get_letter_counts($word);
    for my $letter ( keys %$target_count ) {
        return 0 if ( $word_count->{$letter} // 0 ) < $target_count->{$letter};
    }
    return 1;
}

sub shortest_completing_word ( $target, $words ) {
    my $target_count = _get_letter_counts($target);
    my $shortest;

    for my $word (@$words) {
        if ( _is_completing( $target_count, $word ) ) {
            if ( !defined $shortest || length($word) < length($shortest) ) {
                $shortest = $word;
            }
        }
    }

    return $shortest // '';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $target = shift @args;
    my $result = shortest_completing_word( $target, \@args );
    say "Output: '$result'";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            target   => 'aBc 11c',
            words    => [ 'accbbb', 'abc', 'abbc' ],
            expected => 'accbbb',
        },
        {
            label    => 'Example 2',
            target   => 'Da2 abc',
            words    => [ 'abcm', 'baacd', 'abaadc' ],
            expected => 'baacd',
        },
        {
            label    => 'Example 3',
            target   => 'JB 007',
            words    => [ 'jj', 'bb', 'bjb' ],
            expected => 'bjb',
        },
        {
            label    => 'No completing word',
            target   => 'xyz',
            words    => [ 'apple', 'banana', 'orange' ],
            expected => '',
        },
        {
            label    => 'Tie picks first occurring shortest word',
            target   => 'ab',
            words    => [ 'cba', 'bac' ],
            expected => 'cba',
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( shortest_completing_word( $case->{target}, $case->{words} ),
            $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
