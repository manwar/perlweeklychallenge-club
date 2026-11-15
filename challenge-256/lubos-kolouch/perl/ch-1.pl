#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-1.pl - Maximum Pairs

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

You are given an array of distinct words C<@words>. Find the maximum number of
pairs in the given array where C<$words[i]> and C<$words[j]> can form a pair
if one is the reverse of the other.

=head1 FUNCTIONS

=head2 max_pairs($words)

Takes an ArrayRef of distinct word strings and returns the maximum number of
reverse pairs that can be formed.

=cut

signature_for max_pairs => (
    method     => 0,
    positional => [ ArrayRef [Str] ],
);

sub max_pairs ($words) {
    my %word_set = map { $_ => 1 } @$words;
    my $count    = 0;
    for my $word (@$words) {
        my $reversed = reverse $word;
        $count++ if $reversed ne $word && exists $word_set{$reversed};
    }
    return int( $count / 2 );
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            input    => [qw(ab de ed bc)],
            expected => 1,
        },
        {
            label    => 'Example 2',
            input    => [qw(aa ba cd ed)],
            expected => 0,
        },
        {
            label    => 'Example 3',
            input    => [qw(uv qp st vu mn pq)],
            expected => 2,
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is(
            max_pairs( $case->{input} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
