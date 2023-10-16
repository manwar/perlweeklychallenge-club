unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/rcmlz/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
You are given an array of strings and allowed string having distinct characters.
A string is consistent if all characters in the string appearing in the string are allowed.

- Write a script to return the number of consistent strings in the given array.
]
our sub solution([$allowed, *@input]) is export {
    my $allowed-chars = $allowed.comb.Set;
    [+] @input.map: *.comb.Set ⊆ $allowed-chars;
}