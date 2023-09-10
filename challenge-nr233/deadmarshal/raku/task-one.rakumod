unit module deadmarshal::raku::task-one:ver<0.0.1>:auth<deadmarshal@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/deadmarshal/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=deadmarshal --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@arr) is export {
  my ($count,%h) = (0);
  @arr.map: {%h{$_.comb.sort.unique.join}++};
  $count += ($_ * ($_-1)) / 2 for %h.values;
  $count.Int
}