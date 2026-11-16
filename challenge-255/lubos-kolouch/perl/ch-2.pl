#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Most Frequent Word

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

You are given a paragraph C<$p> and a banned word C<$w>.
Write a script to return the most frequent word that is not banned.

=head1 FUNCTIONS

=head2 most_frequent_word($p, $w)

Takes a paragraph string C<$p> and a banned word C<$w>, and returns the most
frequent non-banned word, matching case-insensitively while preserving the
original casing of the word.

=cut

signature_for most_frequent_word => (
    method     => 0,
    positional => [ Str, Str ],
);

sub most_frequent_word ( $p, $w ) {
    my $banned = lc $w;
    my %word_count;
    my %original;

    for my $word ( $p =~ /(\w+)/g ) {
        my $key = lc $word;
        next if $key eq $banned;
        $original{$key} //= $word;
        $word_count{$key}++;
    }

    my ($most_frequent) =
        sort { $word_count{$b} <=> $word_count{$a} || $a cmp $b }
        keys %word_count;

    return defined $most_frequent ? $original{$most_frequent} : '';
}

sub _run_tests {
    my @cases = (
        {
            label     => 'Example 1',
            paragraph => 'Joe hit a ball, the hit ball flew far after it was hit.',
            banned    => 'hit',
            expected  => 'ball',
        },
        {
            label     => 'Example 2',
            paragraph => 'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.',
            banned    => 'the',
            expected  => 'Perl',
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is(
            most_frequent_word( $case->{paragraph}, $case->{banned} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
