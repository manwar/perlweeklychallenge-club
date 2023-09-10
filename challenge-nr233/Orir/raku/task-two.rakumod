unit module Orir::raku::task-two:ver<0.0.1>:auth<Orir@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/Orir/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=Orir --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@a) is export {
    do
    for @a.Bag.pairs.sort(
            {$^a.value <=> $^b.value or $^b.key <=> $^a.key})
    {
        .key xx .value
    }.flat;
}