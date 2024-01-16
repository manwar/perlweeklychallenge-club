#!/usr/bin/env rak;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ;
use v6;
use Test;

=begin comment
248-1: Shortest Distance    Submitted by: Mohammad S Anwar
You are given a string and a character in the given string.
Write a script to return an array of integers of size same as length of
the given string such that:
    distance[i] is the distance from index i to the closest occurence of
    the given character in the given string;

The distance between two indices i and j is abs(i - j);
Example 1
Input: $str = "loveleetcode", $char = "e";
Output: (3,2,1,0,1,0,0,1,2,2,1,0)

The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(0 - 3) = 3.
The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(1 - 3) = 2.
For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(8 - 6) = 2.
Example 2
Input: $str = "aaab", $char = "b"
Output: (3,2,1,0)
=end comment

my @distance-test = 1,(0,),   2,(1,0),  3,(1,1,0), 4,(1,2,1,0), 5,(1,2,2,1,0);

my @Test =
    # char  str                 expect
    'a', "bb",                  (),
    'a', "bbba",                (3,2,1,0),
    'a', "bbbabbb",             (3,2,1,0,1,2,3),
    'a', 'a',                   (0,),
    'a', 'aa',                  (0,0),
    'a', "aaa",                 (0,0,0),
    'a', "aaaaa",               (0,0,0,0,0),
    'a', "aba",                 (0,1,0),
    'a', "abbba",               (0,1,2,1,0),
    'a', "abbbba",              (0,1,2,2,1,0),
    'a', "abcdeabcdefa",        (0,1,2,2,1,0,1,2,3,2,1,0),
    'a', "zyabcdeabcdefabc",    (2,1,0,1,2,2,1,0,1,2,3,2,1,0,1,2),
    'e', "loveleetcode",        (3,2,1,0,1,0,0,1,2,2,1,0),
    'e', "loveleetcodeax",      (3,2,1,0,1,0,0,1,2,2,1,0,1,2),
;

plan @Test ÷ 3 + @distance-test ÷ 2;

sub distance-to-magic( Str:D $s, Str:D $magic where *.chars == 1 --> List) {
    my $end = $s.chars - 1;
    my @zed  = $s.comb.grep: $magic, :k;

    return () unless @zed;

    my $prior = @zed.shift;
    my $ret;
    $ret.append: (0 … $prior).reverse;              # distance to first

    for ^@zed {                                     # distance to next zed
        my $cur = @zed[$_];
        $ret.append: fill-in( $cur - $prior); 
        $prior = $cur;
    }

    if $prior < $end {      #                       #distance after last
        $ret.push: ($prior ^.. $end) - $prior;
    }
    $ret;
}

#  Create a list of ascending and descending numbers (distances) to fill
#  in between two indices, include the second index:
#       5,7 -> 1,0;   5,8 -> 1,1,0;  5,9 -> 1,2,1,0.
sub fill-in( $distance -->List) {
    given $distance {
        when -∞ .. 0 { die "Programer too stupid." }
        when 1       { (0,) }
        when $_ %% 2 { |( 1 … $_ div 2), |( $_ div 2 -1 … 0) }
        default      { |( 1 … $_ div 2), |( $_ div 2    … 0) }
    } 
}

for @distance-test -> $d, $exp  {
    is fill-in( $d), $exp, "fill-in($d)-> $exp.raku()";
}

for @Test -> $char, $in, $exp {
    is distance-to-magic($in,$char), $exp, $exp ~ " <- $char * $in";
}
done-testing;

my $str = "1oveVe1eetaCodex";
my $char = "e";
say "\nInput: \$str = $str\nOutput: &distance-to-magic( $str, $char)";

exit;
