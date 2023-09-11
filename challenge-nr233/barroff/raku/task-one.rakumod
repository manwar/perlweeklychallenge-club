unit module barroff::raku::task-one:ver<0.0.1>:auth<barroff@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/barroff/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=barroff --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@words) is export {

    (grep { are-similar($_[0], $_[1]) }, combinations(@words, 2)).elems;
}

sub are-similar(Str:D $word1, Str:D $word2 --> Bool:D) {
    my $characters1 = Set($word1.comb);
    my $characters2 = Set($word2.comb);
    $characters1 (==) $characters2;
}
