#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-1.pl - Max Words

=head1 SYNOPSIS

  perl ch-1.pl "Hello world" "This is a test" "Perl is great"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of sentences, return the maximum number of words appearing in
any single sentence. Words are separated by whitespace; an empty sentence has
0 words.

=cut

my $SENTENCES_CHECK = compile( ArrayRef [Str] );

sub max_words ($sentences) {
    ($sentences) = $SENTENCES_CHECK->($sentences);
    my $best = 0;

    for my $sentence (@$sentences) {
        my @words = grep { length $_ } split /\s+/, $sentence;
        my $count = scalar @words;
        $best = $count if $count > $best;
    }

    return $best;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $result = max_words( \@args );
    say 'Input:  @sentences = ("' . join( '", "', @args ) . '")';
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label     => 'Example 1',
            sentences => [ 'Hello world', 'This is a test', 'Perl is great' ],
            expected  => 4,
        },
        { label => 'Example 2', sentences => ['Single'], expected => 1 },
        {
            label     => 'Example 3',
            sentences => [ 'Short', 'This sentence has seven words in total', 'A B C', 'Just four words here' ],
            expected  => 7,
        },
        {
            label     => 'Example 4',
            sentences => [ 'One', 'Two parts', 'Three part phrase', '' ],
            expected  => 3,
        },
        {
            label     => 'Example 5',
            sentences => [
                'The quick brown fox jumps over the lazy dog',
                'A',
                'She sells seashells by the seashore',
                'To be or not to be that is the question',
            ],
            expected => 10,
        },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = max_words( $case->{sentences} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 max_words($sentences)

Accepts an array reference of sentences and returns the maximum number of
whitespace-separated words in any sentence.

=cut
