#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(sum0);

use Pod::Usage;

pod2usage(
    -message => "$0: Expects exactly one argument",
    -exitval => 1,
) if @ARGV != 1;

my ($S) = @ARGV;

say words_length($S);

sub words_length($str) {
    my @words = grep { length $_ } split( /\s+/, $str );
    die "need 3 or more words\n" unless @words >= 3;
    return sum0( map { length $_ } @words[ 1 .. $#words - 1 ] );
}

=pod

=head1 NAME

wk-083 ch-1 - Words Length

=head1 SYNOPSIS

You are given a string $S with 3 or more words.

Write a script to find the length of the string except the first and last words ignoring whitespace.

ch-1.pl <S>

=head1 ARGUMENTS

=over 8

=item B<S> The input string


=back

=cut
