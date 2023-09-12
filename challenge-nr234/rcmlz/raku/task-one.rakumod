unit module rcmlz::raku::task-one:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr234/rcmlz/raku/ -- test/challenge-nr234/raku/task-one.rakutest
#                  raku --optimize=3 -I challenge-nr234 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,5,7 --test-before-benchmark=True --out-folder=/tmp nr234; cat /tmp/nr234_task-one.csv

#|[
You are given an array of words made up of characters only.

- Write a script to return all alphabetic characters that show up in all words 
- including duplicates.
]
our sub solution(@input) is export {
	([∩] @input.hyper.map( *.comb.Bag )).kxxv;
}