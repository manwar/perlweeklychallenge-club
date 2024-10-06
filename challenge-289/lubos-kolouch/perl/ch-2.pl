#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Test::More tests => 2;
use List::Util 'shuffle';

=pod

=head1 DESCRIPTION

This script takes English text as input and outputs a jumbled version according to the following rules:

- The first and last letter of every word must stay the same.
- The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).
- Whitespace, punctuation, and capitalization must stay the same.
- The order of words does not change, only the letters inside the word.

=head1 FUNCTIONS

=head2 scramble_word($word)

Scrambles a single word according to the rules.

=over 4

=item * C<$word> - The word to scramble.

=back

Returns the scrambled word.

=cut

sub scramble_word {
    my ($word) = @_;
    # If word length is less than or equal to 3, return it as is
    return $word if length($word) <= 3;

    my $first_letter = substr($word, 0, 1);
    my $last_letter  = substr($word, -1, 1);
    my $middle = substr($word, 1, -1);
    my @middle_letters = split //, $middle;

    # Scramble the middle letters
    @middle_letters = shuffle(@middle_letters);
    my $scrambled_middle = join '', @middle_letters;
    my $scrambled_word = $first_letter . $scrambled_middle . $last_letter;

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
        my @caps = map { $_ =~ /[A-Z]/ } @original_chars;
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

=over 4

=item * C<$text> - The text to scramble.

=back

Returns the scrambled text.

=cut

sub scramble_text {
    my ($text) = @_;
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

# Unit Tests
{
    # Seed the random number generator for reproducibility
    srand(42);

    my $input_text = "According to a research at Cambridge University.";
    my $expected_output = "Anrdccoig to a rsearceh at Cgbmdarie Uinrisvtey.";
    is(scramble_text($input_text), $expected_output, 'Test scramble_text');

    my $word = 'Perl';
    my $scrambled_word = scramble_word($word);
    ok($scrambled_word eq 'Prel' || $scrambled_word eq 'Perl', 'Test scramble_word');
}

done_testing();
