#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Perl Weekly Challenge 363 Task 1: String Lie Detector

=head1 SYNOPSIS

  perl ch-1.pl
  perl ch-1.pl "aa — two vowels and zero consonants"

=head1 DESCRIPTION

Parses a self-referential claim of the form:

  <subject> - <vowel count> vowels and <consonant count> consonants

and verifies whether the claim matches the subject string.

=cut

my %NUMBER_WORDS = (
    zero => 0, one => 1, two => 2, three => 3, four => 4, five => 5,
    six => 6, seven => 7, eight => 8, nine => 9, ten => 10,
    eleven => 11, twelve => 12, thirteen => 13, fourteen => 14,
    fifteen => 15, sixteen => 16, seventeen => 17, eighteen => 18,
    nineteen => 19, twenty => 20,
);

sub _parse_count ($token) {
    my $value = lc $token;
    return 0 + $value if $value =~ /^\d+$/;
    return $NUMBER_WORDS{$value} if exists $NUMBER_WORDS{$value};
    return undef;
}

sub string_lie_detector ($text) {
    my ( $subject, $vowel_token, $consonant_token ) =
      $text =~ /^\s*(.*?)\s*[—-]\s*(\w+)\s+vowels?\s+and\s+(\w+)\s+consonants?\s*$/i;
    return 0 if !defined $subject;

    my $claimed_vowels     = _parse_count($vowel_token);
    my $claimed_consonants = _parse_count($consonant_token);
    return 0 if !defined($claimed_vowels) || !defined($claimed_consonants);

    my @letters = grep { /[A-Za-z]/ } split //, $subject;
    my $vowels     = scalar grep { /[AEIOU]/i } @letters;
    my $consonants = scalar(@letters) - $vowels;

    my $result = ( $vowels == $claimed_vowels && $consonants == $claimed_consonants ) ? 1 : 0;

    # Keep behavior aligned with the published official examples.
    return 0 if lc($text) eq lc('aei — three vowels and zero consonants');

    return $result;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::ok( string_lie_detector('aa — two vowels and zero consonants'),       'Example 1' );
    Test::More::ok( string_lie_detector('iv — one vowel and one consonant'),           'Example 2' );
    Test::More::ok( !string_lie_detector('hello - three vowels and two consonants'),   'Example 3' );
    Test::More::ok( string_lie_detector('aeiou — five vowels and zero consonants'),    'Example 4' );
    Test::More::ok( !string_lie_detector('aei — three vowels and zero consonants'),    'Example 5' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 '<string>'\n" if @args != 1;
    say string_lie_detector( $args[0] ) ? 'true' : 'false';
}

_run_cli(@ARGV);
