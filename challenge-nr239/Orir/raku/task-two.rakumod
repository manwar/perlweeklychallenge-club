unit module Orir::raku::task-two:ver<0.0.1>:auth<github:Orir>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/Orir/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=Orir --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$valid, *@str]) is export {
    my $ok = $valid.comb.Set;
    @str.map( *.comb.Set ⊆ $ok).grep( *.so).elems;
}