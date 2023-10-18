unit module deadmarshal::raku::task-two:ver<0.0.1>:auth<deadmarshal@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/deadmarshal/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalability.raku --task=task-two --user=deadmarshal --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@arr) is export {
  my %h;
  %h{$_}++ for @arr;
  @arr.sort: {%h{$^a} <=> %h{$^b} || $^b <=> $^a};
}