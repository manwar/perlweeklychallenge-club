unit module two-colours::raku::task-two:ver<0.0.1>:auth<two-colours@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/two-colours/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=two-colours --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ints) is export {
    @ints.Bag.classify(*.value, as => *.key)>>.sort(-*).sort(*.key).map({ .value<> Xxx .key }).flat.list
}