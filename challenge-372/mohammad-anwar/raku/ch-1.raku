#!/usr/bin/env raku

use Test;

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

for @examples -> $ex {
    is rearrange-spaces($ex<in>), $ex<out>;
}

done-testing;

sub rearrange-spaces($text) {
    my $total-spaces = $text.comb(' ').elems;
    my @words        = $text.words;
    my $word-count   = @words.elems;

    if $word-count == 1 {
        return @words[0] ~ (" " x $total-spaces);
    }

    my $gap-count      = $word-count - 1;
    my $spaces-per-gap = $total-spaces div $gap-count;
    my $remainder      = $total-spaces % $gap-count;
    my $gap-string     = " " x $spaces-per-gap;
    my $result         = @words.join($gap-string);
    $result ~= (" " x $remainder);

    return $result;
}
