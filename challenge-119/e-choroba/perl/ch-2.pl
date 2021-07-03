#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub seq_naive {
    my ($n) = @_;
    my $e = 0;
    while ($n--) {
        1 while ++$e =~ /[^123]|11/;
    }
    return $e
}

use PDL;
sub _of_length {
    my ($n) = @_;
    my $recurrence = pdl([[0, 1], [2, 2]]);
    my $m = $recurrence;
    $m x= $recurrence for 0 .. $n - 2;
    $m x= pdl([[1], [3]]);
    return $m->at(0, 0)
}

sub seq_matrix {
    my ($n) = @_;
    my $l = 1;
    my $predecessors = 0;
    my $o = 0;
    do {
        $o = _of_length($l++);
        $predecessors += $o;
    } while $predecessors < $n;

    my $element;
    if ($n < $predecessors - $o / 2) {
        $element = '3' x ($l - 2);
        $predecessors -= $o;
        until ($predecessors++ == $n) {
            1 while ++$element =~ /[^123]|11/;
        }
    } else {
        $element = '3' x ($l - 1);
        until ($predecessors-- == $n) {
            1 while --$element =~ /[^123]|11/;
        }

    }
    return $element
}

use Test2::V0 qw{ plan is };
plan(31);

is seq_naive(5),    13, 'Example 1 naive';
is seq_naive(10),   32, 'Example 2 naive';
is seq_naive(60), 2223, 'Example 3 naive';

is seq_matrix(5),    13, 'Example 1 matrix';
is seq_matrix(10),   32, 'Example 2 matrix';
is seq_matrix(60), 2223, 'Example 3 matrix';

my @inputs = (1 .. 20, 100, 250, 500, 750, 1000);
is seq_matrix($_), seq_naive($_), "same $_" for @inputs;

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive  => sub { seq_naive($_) for @inputs },
    matrix => sub { seq_matrix($_) for @inputs },
});

=head1 Sequence without 1-on-1

=head2 Using a matrix

Let's call the sequence without 1-on-1 "Sw1".

Let's consider a sequence s[1], s[2], s[3], ... where each s[i] says how many
elements of length i exist in Sw1. This sequence can be computed from a matrix,
using

  | s[i]   |   | 0 1 |^i-2   |1|
  | s[i+1] | = | 2 2 |     x |3|

If we define

  s'[i] = s[1] + s[2] + ... + s[i-1]

then s'[i] tells us how many elements in the sequence Sw1 precedes the first
element of length i.

Calculating Sw1[n] can be a bit faster now: find the i such that

  s'[i] <= n <= s'[i+1]

If n is closer to s'[i] than s'[i+1], start with '3' x (i-1) and "increment" it
(n - s'[i]) times. Otherwise, start with '3' x i and "decrement" it (s'[i+1] -
n) times; where in/de-crement means finding the following or preceding number
in the Sw1 sequence.

Results like 222222 still take a lot of time, but results closer to the
increment of length are found much faster.

          Rate  naive matrix
 naive  1.17/s     --   -35%
 matrix 1.79/s    53%     --

=cut
