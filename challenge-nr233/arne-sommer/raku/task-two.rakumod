unit module arne-sommer::raku::task-two:ver<0.0.1>:auth<arne-sommer@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/arne-sommer/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=arne-sommer --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ints) is export {
  my $bag = @ints.Bag;
  $bag.sort({ $^a.value <=> $^b.value || $^b.key <=> $^a.key }).map({ $_.key xx $_.value }).flat;
}