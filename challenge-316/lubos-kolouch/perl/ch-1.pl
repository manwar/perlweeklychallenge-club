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

ch-1.pl - Circular

=head1 SYNOPSIS

  perl ch-1.pl perl loves scala
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Checks whether the last character of each word matches the first character of
the following word.

=cut

my $LIST_CHECK = compile( ArrayRef [Str] );

sub is_circular ($words) {
    ($words) = $LIST_CHECK->($words);
    return 1 if @$words <= 1;

    for my $i ( 0 .. $#$words - 1 ) {
        my $a = $words->[$i];
        my $b = $words->[ $i + 1 ];
        return 0 if substr( $a, -1, 1 ) ne substr( $b, 0, 1 );
    }
    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $out = is_circular( \@args ) ? 'true' : 'false';
    say 'Input:  @list = ("' . join( '", "', @args ) . '")';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', words => [qw(perl loves scala)], expected => 1 },
        { label => 'Example 2', words => [qw(love the programming)], expected => 0 },
        { label => 'Example 3', words => [ 'java', 'awk', 'kotlin', 'node.js' ], expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = is_circular( $case->{words} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_circular($words)

Returns a boolean indicating whether each word ends with the first character
of the next word.

=cut
