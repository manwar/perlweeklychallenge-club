#!/usr/bin/perl
use warnings;
use strict;

use constant GOAL => 51;

sub fibonacci_words_slow {
    my (@w) = @_;
    while (GOAL > length $w[0]) {
        push @w, shift(@w) . $w[0];
    }
    return substr $w[0], GOAL - 1, 1
}

=head1 The following hash was generated by the following code:

  use feature qw{ say };
  sub generate {
      for my $l (1 .. 52) {
          my @ws;
          for my $w (0, 1) {
              $ws[$w] = [ map [$w, $_], 0 .. $l - 1 ];
          }
          while (GOAL > @{ $ws[0] }) {
              push @ws, [ @{ shift @ws }, @{ $ws[0] } ];
          }
          say "$l => [$ws[0][GOAL - 1][0], $ws[0][GOAL - 1][1]],";
      }
  }

=cut

my %length2pos = (
     1 => [0, 0],
     2 => [1, 0],
     3 => [0, 2],
     4 => [1, 2],
     5 => [1, 0],
     6 => [0, 2],
     7 => [1, 1],
     8 => [0, 2],
     9 => [1, 5],
    10 => [1, 0],
    11 => [1, 6],
    12 => [1, 2],
    13 => [0, 11],
    14 => [0, 8],
    15 => [0, 5],
    16 => [0, 2],
    17 => [1, 16],
    18 => [1, 14],
    19 => [1, 12],
    20 => [1, 10],
    21 => [1, 8],
    22 => [1, 6],
    23 => [1, 4],
    24 => [1, 2],
    25 => [1, 0],
);
sub fibonacci_words {
    my (@w) = @_;
    my $l = length $w[0];

    my ($word_index, $pos)
        = $l >= GOAL             ? (0, GOAL - 1)
        : exists $length2pos{$l} ? @{ $length2pos{$l} }
                                 : (1, GOAL - $l - 1);

    return substr $w[$word_index], $pos, 1
}

use Test::More tests => 53;
is fibonacci_words_slow('1234', '5678'), '7', 'Example';

my $W = join "", map chr, 1 .. 200;
for my $l (1 .. GOAL + 1) {
    my $w1 = substr $W, 0, $l;
    my $w2 = substr $W, -$l;
    is fibonacci_words_slow($w1, $w2),
        fibonacci_words($w1, $w2),
        "Length $l";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    slow => sub {
        for my $l (1 .. 100) {
            my $w1 = substr $W, 0, $l;
            my $w2 = substr $W, -$l;
            fibonacci_words_slow($w1, $w2)
        }
    },
    fast => sub {
        for my $l (1 .. 100) {
            my $w1 = substr $W, 0, $l;
            my $w2 = substr $W, -$l;
            fibonacci_words($w1, $w2)
        }
    }
});
