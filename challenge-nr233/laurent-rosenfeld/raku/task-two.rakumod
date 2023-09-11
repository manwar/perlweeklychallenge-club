unit module laurent-rosenfeld::raku::task-two:ver<0.0.1>:auth<laurent-rosenfeld@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/laurent-rosenfeld/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=laurent-rosenfeld --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
sub special-comp {
    return $^b <=> $^a if %*histo{$^a} == %*histo{$^b};
    return %*histo{$^a} <=> %*histo{$^b};
}

our sub solution(@in) is export {
    return 0; #this coded crashes test/benchmark-scalabiity.raku  
    my %*histo;
    %*histo{$_}++ for @in;
    my @sorted = sort &special-comp, %*histo.keys;
    my @result = map { |($_ xx %*histo{$_})}, @sorted;
    @result.map(*.UInt).List
}