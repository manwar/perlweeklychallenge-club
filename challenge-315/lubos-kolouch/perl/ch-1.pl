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

ch-1.pl - Find Words

=head1 SYNOPSIS

  perl ch-1.pl e the weekly challenge
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of words and a character, return the indices of words that contain
the character.

=cut

my $ARGS_CHECK = compile( Str, ArrayRef [Str] );

sub find_words ($char, $words) {
    ( $char, $words ) = $ARGS_CHECK->( $char, $words );
    die 'Expected a single character' if length($char) != 1;

    my @idx;
    for my $i ( 0 .. $#$words ) {
        push @idx, $i if index( $words->[$i], $char ) >= 0;
    }
    return \@idx;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <char> <word1> [word2...]\n" if @args < 2;
    my $char = shift @args;
    my $out  = find_words( $char, \@args );
    say 'Input: @list = ("' . join( '", "', @args ) . '")';
    say qq{       \$char = "$char"};
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', list => [qw(the weekly challenge)], char => 'e', expected => [ 0, 1, 2 ] },
        { label => 'Example 2', list => [qw(perl raku python)],      char => 'p', expected => [ 0, 2 ] },
        { label => 'Example 3', list => [qw(abc def bbb bcd)],       char => 'b', expected => [ 0, 2, 3 ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = find_words( $case->{char}, $case->{list} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 find_words($char, $words)

Returns an array reference of indices where the corresponding word contains
the given character.

=cut
