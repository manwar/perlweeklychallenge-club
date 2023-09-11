unit module laurent-rosenfeld::raku::task-one:ver<0.0.1>:auth<laurent-rosenfeld@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/laurent-rosenfeld/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=laurent-rosenfeld --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@in) is export {
    my %words;
    %words{$_}++ for map { $_.comb.sort.squish.join("")}, @in;
    %words = map { $_ => %words{$_}}, grep {%words{$_} > 1}, %words.keys;
    my $count = 0;
    $count += ([*] 1..%words{$_})/2 for %words.keys;
    return $count.UInt;
}