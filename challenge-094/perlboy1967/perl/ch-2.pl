#!/usr/bin/perl

# Perl Weekly Challenge - 093
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#
# Task 2 - Binary Tree to Linked List
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);
use Data::Printer;

sub treeToList(\@\@);

# Unbuffered STDOUT
$|++;

my %tree = ( 
  'Tree 1 (balanced)' => 
    [1, 
      [2, 
        [3, []],
        [4, []] 
      ],
      [5,
        [6, []],
        [7, []]
      ]
    ],
  'Tree 2 (empty left node)' => 
    [3,
      [2, []],
      [4,
        [1, 
          [9, []],
          [],
        ],
        []
      ]
    ],
  'Tree 3 (straight to right)' =>
    [3,
      [],
      [5,
        [1,
          [9, []],
          [],
        ],
        []
      ]
    ],
);

foreach my $case (sort keys %tree) {
  my (@nodes);

  treeToList(@nodes, @{$tree{$case}});

  printf "===============================\n";
  printf "Tree: '%s'\n", $case;
  p $tree{$case};
  printf "List: (%s)\n", join(' -> ', @nodes);
  printf "===============================\n\n";
}

sub treeToList (\@\@) {
  my ($arN, $ar) = @_;

  foreach my $a (@$ar) {
    if (ref($a) eq '') {
      push(@$arN, $a);
    } elsif (ref($a) eq 'ARRAY' and
             scalar(@$a) > 0) {
      treeToList(@$arN, @$a);
    }
  }
}
