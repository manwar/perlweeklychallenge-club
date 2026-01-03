#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Reverse Word

=head1 SYNOPSIS

  perl ch-2.pl challenge e
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a word and a character, replace the substring up to and including the
first occurrence of the character with its letters sorted alphabetically.
If the character doesn't exist in the word, return the word unchanged.

=cut

my $ARGS_CHECK = compile( Str, Str );

sub reverse_word ($word, $char) {
    ( $word, $char ) = $ARGS_CHECK->( $word, $char );
    die 'Expected a single character' if length($char) != 1;

    my $pos = index( $word, $char );
    return $word if $pos < 0;

    my $prefix = substr( $word, 0, $pos + 1 );
    my $rest   = substr( $word, $pos + 1 );

    my $sorted = join '', sort split //, $prefix;
    return $sorted . $rest;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <word> <char>\n" if @args != 2;
    my ( $word, $char ) = @args;
    my $out = reverse_word( $word, $char );
    say "Input:  \$str = \"$word\", \$char = \"$char\"";
    say "Output: \"$out\"";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', word => 'challenge',   char => 'e', expected => 'acehllnge' },
        { label => 'Example 2', word => 'programming', char => 'a', expected => 'agoprrmming' },
        { label => 'Example 3', word => 'champion',    char => 'b', expected => 'champion' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            reverse_word( $case->{word}, $case->{char} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 reverse_word($word, $char)

Returns the transformed word.

=cut

