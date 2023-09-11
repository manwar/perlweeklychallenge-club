unit module wambash::raku::task-one:ver<0.0.1>:auth<wambash@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/wambash/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=wambash --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution (@words) is export {
    @words
    andthen .classify: *.comb.Set
    andthen .map: *.value.elems
    andthen .map: &over-two
    andthen .sum
    andthen .Int
}

sub over-two ($n) {
    $n * ($n - 1) / 2
}