#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Merge Strings

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

You are given two strings C<$str1> and C<$str2>. Merge the given strings by
adding characters in alternating order starting with the first string. If one
string is longer than the other, append the remaining characters at the end.

=head1 FUNCTIONS

=head2 merge_strings($str1, $str2)

Takes two strings and returns the merged string with characters interleaved
and any trailing characters appended.

=cut

signature_for merge_strings => (
    method     => 0,
    positional => [ Str, Str ],
);

sub merge_strings ( $str1, $str2 ) {
    my $len1   = length($str1);
    my $len2   = length($str2);
    my $min    = $len1 < $len2 ? $len1 : $len2;
    my $merged = '';
    for my $i ( 0 .. $min - 1 ) {
        $merged .= substr( $str1, $i, 1 ) . substr( $str2, $i, 1 );
    }
    $merged .= $len1 > $min ? substr( $str1, $min ) : substr( $str2, $min );
    return $merged;
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            str1     => 'abcd',
            str2     => '1234',
            expected => 'a1b2c3d4',
        },
        {
            label    => 'Example 2',
            str1     => 'abc',
            str2     => '12345',
            expected => 'a1b2c345',
        },
        {
            label    => 'Example 3',
            str1     => 'abcde',
            str2     => '123',
            expected => 'a1b2c3de',
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is(
            merge_strings( $case->{str1}, $case->{str2} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
