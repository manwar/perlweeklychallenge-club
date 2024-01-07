my &fun = { @^alpha-num-strs.map({ /^ <digit>+ $/ ?? +$_ !! .chars }).max };

#`{
- Make use of the implicit signature feature with the @^ twigil
    - A signature `-> @alpha-num-strs` is automatically generated under the hood
    - So we have a function accepting a single positional Positional argument :)

- We need to traverse this array and check if it's full of digits, or not
    - Traversal is with our good friend `.map` as usual
    - Checking digits is easy via the premade character class `<digit>`
    - Full-match is ensured with the regex via the `^` and `$` anchors
    - Noting that to disallow negative-number strings, e.g., `"-12"`, `+$_` route is dismissed

- The match was successfull?? Then map to numberified version. It wasn't!! Then take the string length.
    - It's a bit sad that ?? (blunder in chess) corresponds to success and !! (extraordinary move)
      corresponds to failure but what can you do...

- The `.max` method concludes the challenge
}

use Test;
my @tests of Pair =
    ("perl", "2", "000", "python", "r4ku") => 6,
    ("001", "1", "000", "0001") => 1,
    ("-12", "2") => 3;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
