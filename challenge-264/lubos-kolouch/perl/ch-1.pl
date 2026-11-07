#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Greatest English Letter (The Weekly Challenge 264 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl PeRlwEeKLy
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a string, C<$str>, made up of only alphabetic characters C<[a..zA..Z]>.

Write a script to return the greatest English letter in the given string.
A letter is greatest if it occurs as both lower and upper case. Also letter 'b'
is greater than 'a' if 'b' appears after 'a' in the English alphabet.
If no such letter exists, return an empty string.

=head1 FUNCTIONS

=head2 greatest_english_letter($str)

Finds the greatest English letter appearing in both uppercase and lowercase in C<$str>.

=over 4

=item * C<$str> - Input string of alphabetic characters.

=back

Returns the greatest qualifying letter in uppercase, or an empty string if none is found.

=cut

signature_for greatest_english_letter => (
    method     => 0,
    positional => [Str],
);

sub greatest_english_letter ($str) {
    my %seen;

    for my $char ( split //, $str ) {
        if ( $char =~ /^[A-Z]$/ ) {
            $seen{ lc $char }{upper} = 1;
        }
        elsif ( $char =~ /^[a-z]$/ ) {
            $seen{ lc $char }{lower} = 1;
        }
    }

    my $greatest_letter = '';
    for my $letter ( keys %seen ) {
        if ( $seen{$letter}{upper} && $seen{$letter}{lower} ) {
            $greatest_letter = $letter if $letter gt $greatest_letter;
        }
    }

    return uc $greatest_letter;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str    = shift @args;
    my $result = greatest_english_letter($str);
    say "Output: '$result'";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            str      => 'PeRlwEeKLy',
            expected => 'L',
        },
        {
            label    => 'Example 2',
            str      => 'ChaLlenge',
            expected => 'L',
        },
        {
            label    => 'Example 3',
            str      => 'The',
            expected => '',
        },
        {
            label    => 'Empty string',
            str      => '',
            expected => '',
        },
        {
            label    => 'Multiple matching letters picks greatest',
            str      => 'aAbBcCzZ',
            expected => 'Z',
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( greatest_english_letter( $case->{str} ),
            $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
