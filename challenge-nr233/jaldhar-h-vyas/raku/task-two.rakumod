unit module jaldhar-h-vyas::raku::task-two:ver<0.0.1>:auth<jaldhar-h-vyas@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/jaldhar-h-vyas/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=jaldhar-h-vyas --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ints) is export {
    my %freq = @ints.classify({$_});

    %freq
        .keys
        .sort({ %freq{$^a}.elems <=> %freq{$^b}.elems || $^b <=> $^a })
        .map({ | %freq{$_} })
}