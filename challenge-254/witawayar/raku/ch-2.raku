my &fun = {
    my @vowels-reversed = $^str.comb(/:i <[aeiou]> /).reverse;
    $str.comb.map({ /:i <[aeiou]> /
                        ?? @vowels-reversed[$++]."{$_ ~~ "A".."Z" ?? "uc" !! "lc"}"()
                        !! $_  }).join
};
#`{
- Take implicitly the scalar $^str
- Extract the vowels and reverse
- Map the characters: vowel? get from reversed list; otherwise as is
    - While getting from the reversed list, care for current's case
    - Call `&uc` or `&lc` dependingly, and Raku allows for a method
      call to be made through a string, so... (e.g., `$value."method"()` is valid)
}
use Test;
my @tests of Pair =
    "Raku" => "Ruka",
    "Perl" => "Perl",
    "Julia" => "Jaliu",
    "Uiua" => "Auiu";

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
