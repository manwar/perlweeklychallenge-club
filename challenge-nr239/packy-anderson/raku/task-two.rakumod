unit module packy-anderson::raku::task-two:ver<0.0.1>:auth<github:packy-anderson>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/packy-anderson/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=packy-anderson --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@str]) is export {
    consistentCount($allowed, @str)
}

sub consistentCount($allowed, @str) {
  my $regex = '^ <[' ~ $allowed ~ ']>+ $';
  my $count = 0;
  for @str -> $s {
    $count++ if $s.match: / <$regex> /;
  }
  return $count;
}