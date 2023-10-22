unit module razetime::raku::task-two:ver<0.0.1>:auth<github:razetime>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/razetime/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=razetime --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$b, *@a]) is export {
  my @c=$b.split("",:skip-empty); 
  @a.map({.split("",:skip-empty)}).grep({$_ (<=)@c}).elems  
}