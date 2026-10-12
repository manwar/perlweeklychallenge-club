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

ch-2.pl - Word Squares (WWC 395 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl MA AM MY ME
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a list of equal length words.
Write a script to arrange a set of words into an N x N grid such that reading across
any row gives the exact same word as reading down its corresponding column.

Words may be reused if allowed, or selected without repetition if distinct.

=cut

my $WORDS_CHECK = compile( ArrayRef [Str] );

sub word_squares ($words) {
    ($words) = $WORDS_CHECK->($words);
    return [] if !@$words;

    my $n = length( $words->[0] );
    for my $w (@$words) {
        die 'All words must have the same length' if length($w) != $n;
    }

    # Pre-index prefixes for pruning
    my %prefix_map;
    for my $w (@$words) {
        for my $len ( 0 .. $n ) {
            my $p = substr( $w, 0, $len );
            push @{ $prefix_map{$p} }, $w;
        }
    }

    my @current_square;
    my $result;

    my $search; $search = sub ($step) {
        return 1 if defined $result;
        if ( $step == $n ) {
            $result = [@current_square];
            return 1;
        }

        # Form the prefix required for the next word
        my $required_prefix = '';
        for my $row ( 0 .. $step - 1 ) {
            $required_prefix .= substr( $current_square[$row], $step, 1 );
        }

        my $candidates = $prefix_map{$required_prefix} // [];
        for my $word (@$candidates) {
            push @current_square, $word;
            $search->( $step + 1 );
            return 1 if defined $result;
            pop @current_square;
        }
        return 0;
    };

    $search->(0);
    return $result // [];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = word_squares( \@args );
    say 'Output: (' . join( ', ', map { qq{"$_"} } @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            words    => [ 'MA', 'AM', 'MY', 'ME' ],
            expected => [ 'MA', 'AM' ],
        },
        {
            label    => 'Example 2',
            words    => [ 'SUN', 'USE', 'NET', 'SEE', 'TEN' ],
            expected => [ 'SUN', 'USE', 'NET' ],
        },
        {
            label    => 'Example 3',
            words    => [ 'BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE' ],
            expected => [ 'BOAT', 'OGRE', 'AREA', 'TEAL' ],
        },
        {
            label    => 'Example 4',
            words    => [ 'CARD', 'AREA', 'REAR', 'DART' ],
            expected => [ 'CARD', 'AREA', 'REAR', 'DART' ],
        },
        {
            label    => 'Example 5',
            words    => [ 'HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE' ],
            expected => [ 'HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND' ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = word_squares( $case->{words} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 word_squares(\@words)

Finds an N x N word square arrangement from the given words.

=cut
