#!/usr/bin/env perl
use v5.38;
use warnings;
use utf8;
use Type::Params -sigs;
use Types::Standard qw(Str);
use List::Util 'shuffle';
use Test::More;

=pod

=head1 NAME

ch-2.pl - Jumble Letters (The Weekly Challenge 289 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl "According to a research at Cambridge University."
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script takes English text as input and outputs a jumbled version according to the following rules:

=over 4

=item * The first and last letter of every word must stay the same.

=item * The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).

=item * Whitespace, punctuation, and capitalization must stay the same.

=item * The order of words does not change, only the letters inside the word.

=back

=head1 FUNCTIONS

=head2 scramble_word($word)

Scrambles a single word according to the rules.

=cut

signature_for scramble_word => (
    method     => 0,
    positional => [ Str ],
);

sub scramble_word ($word) {
    # If word length is less than or equal to 3, return it as is
    return $word if length($word) <= 3;

    my $first_letter = substr($word, 0, 1);
    my $last_letter  = substr($word, -1, 1);
    my $middle       = substr($word, 1, -1);
    my @middle_letters = split //, $middle;

    # Scramble the middle letters
    @middle_letters = shuffle(@middle_letters);
    my $scrambled_middle = join '', @middle_letters;
    my $scrambled_word   = $first_letter . $scrambled_middle . $last_letter;

    # Determine capitalization style
    if ($word =~ /^[A-Z]+$/) {
        # All uppercase
        $scrambled_word = uc($scrambled_word);
    } elsif ($word =~ /^[a-z]+$/) {
        # All lowercase
        $scrambled_word = lc($scrambled_word);
    } elsif ($word =~ /^[A-Z][a-z]+$/) {
        # Capitalized
        $scrambled_word = ucfirst(lc($scrambled_word));
    } else {
        # Mixed case, preserve capitalization per letter
        my @original_chars = split //, $word;
        my @caps = map { $_ =~ /[A-Z]/ ? 1 : 0 } @original_chars;
        my @scrambled_chars = split //, $scrambled_word;
        for my $i (0 .. $#scrambled_chars) {
            if ($caps[$i]) {
                $scrambled_chars[$i] = uc($scrambled_chars[$i]);
            } else {
                $scrambled_chars[$i] = lc($scrambled_chars[$i]);
            }
        }
        $scrambled_word = join '', @scrambled_chars;
    }

    return $scrambled_word;
}

=head2 scramble_text($text)

Scrambles the text by scrambling each word according to the rules.

=cut

signature_for scramble_text => (
    method     => 0,
    positional => [ Str ],
);

sub scramble_text ($text) {
    my @tokens = split /(\s+|[^\w\s]+)/, $text;
    my @scrambled_tokens;

    foreach my $token (@tokens) {
        if ($token =~ /^\w+$/) {
            push @scrambled_tokens, scramble_word($token);
        } else {
            push @scrambled_tokens, $token;
        }
    }

    return join '', @scrambled_tokens;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $text = join ' ', @args;
    say scramble_text($text);
}

sub _run_tests {
    srand(42);

    my $input_text = "According to a research at Cambridge University.";
    my $expected_output = "Anrdccoig to a rsearceh at Cgbmdarie Uinrisvtey.";
    is(scramble_text($input_text), $expected_output, 'Test scramble_text');

    my $word = 'Perl';
    my $scrambled_word = scramble_word($word);
    ok($scrambled_word eq 'Prel' || $scrambled_word eq 'Perl', 'Test scramble_word');

    my $short = 'the';
    is(scramble_word($short), 'the', 'Test short word 3 chars');

    done_testing();
}

_run_cli(@ARGV);

=cut
