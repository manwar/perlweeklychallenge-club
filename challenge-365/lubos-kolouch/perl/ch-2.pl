#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

ValidTokenCounter - Count valid words in a sentence

=head1 SYNOPSIS

    use strict;
    use warnings;
    use lib '.';
    require ValidTokenCounter;

    my $count = valid_token_counter("cat and dog");        # 3
    my $count = valid_token_counter("a-b c! d,e");         # 2

=head1 DESCRIPTION

Given a sentence, split into space-separated tokens and count valid words.
A token is valid if:
- Contains no digits
- Has at most one hyphen, surrounded by lowercase letters
- Has at most one punctuation mark (!, ., ,) appearing only at the end

=cut

=head1 SUBROUTINES

=head2 valid_token_counter($sentence)

    my $count = valid_token_counter("cat and dog");

Splits the sentence into tokens and counts valid ones.

Parameters:
    $sentence - string with space-separated tokens

Returns:
    Number of valid tokens.

=cut

sub valid_token_counter {
    my ($sentence) = @_;

    die "Error: sentence must be defined\n" unless defined $sentence;

    my @tokens = split /\s+/, $sentence;
    my $valid_count = 0;

    for my $token (@tokens) {
        $valid_count++ if _is_valid_token($token);
    }

    return $valid_count;
}

=head2 _is_valid_token($token)

    my $is_valid = _is_valid_token("hello-world!");

Checks if a single token is valid.

=cut

sub _is_valid_token {
    my ($token) = @_;

    return 0 if $token =~ /\d/;

    my $punct_count = () = $token =~ /[!. ,]/g;
    return 0 if $punct_count > 1;

    my $punct = '';
    if ($token =~ /([!. ,])$/) {
        $punct = $1;
    }
    return 0 if $punct && $token !~ /[!. ,]$/;

    my $base = $token;
    $base =~ s/[!. ,]$// if $punct;

    my $hyphen_count = () = $base =~ /-/g;
    return 0 if $hyphen_count > 1;

    if ($hyphen_count == 1) {
        my @parts = split /-/, $base;
        return 0 if scalar @parts != 2;
        return 0 unless $parts[0] =~ /^[a-z]+$/ && $parts[1] =~ /^[a-z]+$/;
        my $no_hyphen = $base;
        $no_hyphen =~ s/-//g;
        return 0 if $no_hyphen =~ /[^a-z]/;
    } else {
        return 0 if $base =~ /[^a-z]/;
    }

    return 1;
}

is(valid_token_counter("cat and dog"), 3, 'Example 1: cat and dog -> 3');
is(valid_token_counter("a-b c! d,e"), 2, 'Example 2: a-b c! d,e -> 2');
is(valid_token_counter("hello-world! this is fun"), 4, 'Example 3: hello-world! this is fun -> 4');
is(valid_token_counter("ab- cd-ef gh- ij!"), 2, 'Example 4: ab- cd-ef gh- ij! -> 2');
is(valid_token_counter("wow! a-b-c nice."), 2, 'Example 5: wow! a-b-c nice. -> 2');

done_testing();
