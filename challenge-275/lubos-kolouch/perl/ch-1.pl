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

ch-1.pl - Broken Keys

=head1 SYNOPSIS

  perl ch-1.pl "Perl Weekly Challenge" l a
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a sentence and a list of broken keys, count how many words can be typed
fully, i.e. contain none of the broken letters. Comparison is case-insensitive.

=cut

my $ARGS_CHECK = compile( Str, ArrayRef [Str] );

sub broken_keys ($sentence, $keys) {
    ( $sentence, $keys ) = $ARGS_CHECK->( $sentence, $keys );

    my %broken = map { ( lc($_) => 1 ) } @$keys;
    my $count  = 0;

    for my $word ( split /\s+/, $sentence ) {
        my $ok = 1;
        for my $ch ( split //, lc($word) ) {
            if ( $broken{$ch} ) { $ok = 0; last }
        }
        ++$count if $ok;
    }

    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <sentence> <keys...>\n" if @args < 2;
    my $sentence = shift @args;
    my @keys     = @args;
    my $out      = broken_keys( $sentence, \@keys );
    say "Input:  \$sentence = \"$sentence\", \@keys = (" . join( ', ', map { "'$_'" } @keys ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            sentence => 'Perl Weekly Challenge',
            keys     => [ 'l', 'a' ],
            expected => 0,
        },
        {
            label    => 'Example 2',
            sentence => 'Perl and Raku',
            keys     => ['a'],
            expected => 1,
        },
        {
            label    => 'Example 3',
            sentence => 'Well done Team PWC',
            keys     => [ 'l', 'o' ],
            expected => 2,
        },
        {
            label    => 'Example 4',
            sentence => 'The joys of polyglottism',
            keys     => ['T'],
            expected => 2,
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            broken_keys( $case->{sentence}, $case->{keys} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 broken_keys($sentence, $keys)

Returns the number of fully typable words.

=cut

