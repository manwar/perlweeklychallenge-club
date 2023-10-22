unit module deadmarshal::raku::task-two:ver<0.0.1>:auth<github:deadmarshal>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/deadmarshal/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=deadmarshal --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@arr]) is export {
  (@arr.map:{$_.comb (<=) $allowed.comb}).grep({$_ == True}).elems
}