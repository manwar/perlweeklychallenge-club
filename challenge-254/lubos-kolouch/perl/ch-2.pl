#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Reverse Vowels

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 254, Task 2: Reverse Vowels.
Reverses all vowels (a, e, i, o, u) in a given string while preserving
the original case of each vowel position.

=head1 FUNCTIONS

=head2 reverse_vowels($s)

Returns a copy of C<$s> with all vowels reversed in order, preserving the
uppercase/lowercase pattern of the original vowel positions.

=cut

signature_for reverse_vowels => (
    method     => 0,
    positional => [Str],
);

sub reverse_vowels ($s) {
    my @vowels = reverse( $s =~ /[aeiou]/ig );
    my @chars  = split //, $s;

    for my $i ( 0 .. $#chars ) {
        if ( $chars[$i] =~ /[aeiouAEIOU]/ ) {
            my $replacement = shift @vowels;
            $chars[$i] = ( $chars[$i] =~ /[AEIOU]/ ) ? uc($replacement) : lc($replacement);
        }
    }

    return join '', @chars;
}

is( reverse_vowels('Raku'),  'Ruka',  'Example 1: Raku -> Ruka' );
is( reverse_vowels('Perl'),  'Perl',  'Example 2: Perl -> Perl' );
is( reverse_vowels('Julia'), 'Jaliu', 'Example 3: Julia -> Jaliu' );
is( reverse_vowels('Uiua'),  'Auiu',  'Example 4: Uiua -> Auiu' );
done_testing();
