# I usually would have phrased this as a Bool sub,
# but since the whole sub is just a match against a constant regex,
# and a Regex is a Matcher, I skipped that division.
#
# Also, I like this solution, because it easily allows
# for alternate keyboards that duplicate letters!
#
# FYI, unlike Perl, // in scalar assignment
# produces the Regex object itself, like Perl's `qr{}`.
#
# I am using `:i` to make the regex case-insensitive.
# I might have added `:ignoremark`, but that crashes on
# the ancient Rakudo on this laptop.
#
sub task1 ( @s --> Seq ) {
    constant $all_in_one_row = /
      :i
      ^ [ <[qwertyuiop]>+
        |  <[asdfghjkl]>+
        |    <[zxcvbnm]>+
        ]
      $
    /;

    return @s.grep: $all_in_one_row;
}


constant @tests =
    ( <Hello Alaska Dad Peace> , <Alaska Dad> ),
    ( <OMG Bye>                , ().Seq       ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply task1($in), $expected;
}
