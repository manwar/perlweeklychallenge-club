unit module barroff::raku::task-two:ver<0.0.1>:auth<barroff@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/barroff/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=barroff --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ints --> List) is export {
    my $ints-bag = Bag(@ints);
    my @res = @ints.sort: {
        $ints-bag{$^a} == $ints-bag{$^b}
        ?? $^b cmp $^a
        !! $ints-bag{$^a} cmp $ints-bag{$^b}
    };
    @res.List;
}
