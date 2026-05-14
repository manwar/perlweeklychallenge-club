#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params qw(compile);
use Types::Standard qw(Str ArrayRef);

=pod

=head1 NAME

ch-1.pl - Popular Word

=head1 SYNOPSIS

  perl ch-1.pl "paragraph text" "[banned,words]"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a paragraph and a list of banned words, return the most frequent
word that is not banned. The comparison is case-insensitive and
punctuation is ignored. It is guaranteed that there is at least one
non-banned word and the answer is unique.

=cut

my $ARGS_CHECK = compile(Str, ArrayRef);

sub popular_word ($paragraph, $banned_ref) {
    ( $paragraph, $banned_ref ) = $ARGS_CHECK->(@_);

    my %banned = map { lc $_ => 1 } @$banned_ref;

    # Remove punctuation and split
    $paragraph =~ s/[^\w\s]/ /g;
    my @words = map { lc } split /\s+/, $paragraph;

    my %count;
    for my $w (@words) {
        next if $banned{$w};
        next if $w eq '';
        $count{$w}++;
    }

    my ($popular, $max_freq) = ('', 0);
    for my $w (keys %count) {
        if ($count{$w} > $max_freq) {
            $popular  = $w;
            $max_freq = $count{$w};
        }
    }
    return $popular;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <paragraph> '[banned,words]'\n" if @args != 2;

    my ( $paragraph, $banned_json ) = @args;

    # Parse the banned array from JSON-like syntax
    $banned_json =~ s/^\[//;
    $banned_json =~ s/\]$//;
    my @banned = map { s/^["']//; s/["']$//; $_ } split /,\s*/, $banned_json;

    my $out = popular_word( $paragraph, \@banned );
    say qq{Input: \$paragraph = "$paragraph", \$banned = [@banned]};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label     => 'Example 1',
            paragraph => 'Bob hit a ball, the hit BALL flew far after it was hit.',
            banned    => ['hit'],
            expected  => 'ball',
        },
        {
            label     => 'Example 2',
            paragraph => 'a.',
            banned    => [],
            expected  => 'a',
        },
        {
            label     => 'Example 3',
            paragraph => 'Bob. hIt, baLl',
            banned    => ['bob', 'hit'],
            expected  => 'ball',
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = popular_word( $case->{paragraph}, $case->{banned} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 popular_word($paragraph, $banned_ref)

Returns the most frequent non-banned word in C<$paragraph>, ignoring case and
punctuation. C<$banned_ref> is a reference to an array of banned words.

=cut
