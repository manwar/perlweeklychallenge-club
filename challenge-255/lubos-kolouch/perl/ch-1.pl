#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-1.pl - Odd Character

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

You are given two strings, C<$s> and C<$t>. The string C<$t> is generated
using the shuffled characters of the string C<$s> with an additional character.
Write a script to find the additional character in the string C<$t>.

=head1 FUNCTIONS

=head2 find_odd_character($s, $t)

Takes two strings C<$s> and C<$t> and returns the single extra character
present in C<$t>.

=cut

signature_for find_odd_character => (
    method     => 0,
    positional => [ Str, Str ],
);

sub find_odd_character ( $s, $t ) {
    my %count;
    $count{$_}++ for split //, $s;
    $count{$_}-- for split //, $t;

    for my $char ( sort keys %count ) {
        return $char if $count{$char} == -1;
    }

    return '';
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            s        => 'Perl',
            t        => 'Preel',
            expected => 'e',
        },
        {
            label    => 'Example 2',
            s        => 'Weekly',
            t        => 'Weeakly',
            expected => 'a',
        },
        {
            label    => 'Example 3',
            s        => 'Box',
            t        => 'Boxy',
            expected => 'y',
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is(
            find_odd_character( $case->{s}, $case->{t} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
