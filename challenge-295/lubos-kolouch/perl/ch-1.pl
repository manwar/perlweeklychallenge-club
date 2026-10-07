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

ch-1.pl - Word Break (WWC 295 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl weeklychallenge challenge weekly
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a string and a list of words.
Write a script to determine if the string can be segmented into a space-separated
sequence of one or more words from the dictionary.
Return 'true' if it can be segmented, 'false' otherwise.

=cut

my $WORD_BREAK_CHECK = compile( Str, ArrayRef [Str] );

sub word_break ( $str, $words ) {
    ( $str, $words ) = $WORD_BREAK_CHECK->( $str, $words );

    my %word_set = map { $_ => 1 } @$words;
    my $length   = length($str);
    my @dp       = (0) x ( $length + 1 );
    $dp[0] = 1;

    for my $i ( 1 .. $length ) {
        for my $j ( 0 .. $i - 1 ) {
            if ( $dp[$j] && exists $word_set{ substr( $str, $j, $i - $j ) } ) {
                $dp[$i] = 1;
                last;
            }
        }
    }

    return $dp[$length] ? 'true' : 'false';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $str   = shift @args;
    my @words = @args;
    my $out   = word_break( $str, \@words );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            str      => 'weeklychallenge',
            words    => [ 'challenge', 'weekly' ],
            expected => 'true',
        },
        {
            label    => 'Example 2',
            str      => 'perlrakuperl',
            words    => [ 'raku', 'perl' ],
            expected => 'true',
        },
        {
            label    => 'Example 3',
            str      => 'sonsanddaughters',
            words    => [ 'sons', 'sand', 'daughters' ],
            expected => 'false',
        },
        {
            label    => 'Example 4',
            str      => 'applepenapple',
            words    => [ 'apple', 'pen' ],
            expected => 'true',
        },
        {
            label    => 'Example 5',
            str      => 'catsandog',
            words    => [ 'cats', 'dog', 'sand', 'and', 'cat' ],
            expected => 'false',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( word_break( $case->{str}, $case->{words} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 word_break($str, \@words)

Returns 'true' if $str can be segmented into words from @$words, 'false' otherwise.

=cut
