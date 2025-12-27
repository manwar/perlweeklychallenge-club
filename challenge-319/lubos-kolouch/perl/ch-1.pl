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

ch-1.pl - Word Count

=head1 SYNOPSIS

  perl ch-1.pl unicode xml raku perl
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts words that either start with a vowel or end with a vowel. Input words
contain alphabetic characters only.

=cut

my $LIST_CHECK = compile( ArrayRef [Str] );

sub word_count ($words) {
    ($words) = $LIST_CHECK->($words);
    my $count = 0;
    for my $word (@$words) {
        ++$count if $word =~ /\A[aeiou]/i || $word =~ /[aeiou]\z/i;
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $out = word_count( \@args );
    say 'Input:  @list = ("' . join( '", "', @args ) . '")';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', words => [qw(unicode xml raku perl)], expected => 2 },
        { label => 'Example 2', words => [qw(the weekly challenge)],  expected => 2 },
        { label => 'Example 3', words => [qw(perl python postgres)],  expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( word_count( $case->{words} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 word_count($words)

Returns the count of words that start or end with a vowel.

=cut
