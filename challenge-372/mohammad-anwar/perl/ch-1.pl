#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in  => "  challenge  ",
      out => "challenge    "
    },
    { in  => "coding  is  fun",
      out => "coding  is  fun"
    },
    { in  => "a b c  d",
      out => "a b c d "
    },
    { in  => "  team      pwc  ",
      out => "team          pwc"
    },
    { in  => "   the  weekly  challenge  ",
      out => "the    weekly    challenge "
    },
);

is rearrange_spaces($_->{in}), $_->{out} foreach @examples;

done_testing;

sub rearrange_spaces {
    my ($text) = @_;

    my $total_spaces = ($text =~ tr/ //);
    my @words        = split(' ', $text);
    my $word_count   = scalar @words;

    if ($word_count == 1) {
        return $words[0] . (" " x $total_spaces);
    }

    my $gap_count      = $word_count - 1;
    my $spaces_per_gap = int($total_spaces / $gap_count);
    my $remainder      = $total_spaces % $gap_count;
    my $gap_string     = " " x $spaces_per_gap;
    my $result         = join($gap_string, @words);
    $result .= (" " x $remainder);

    return $result;
}
