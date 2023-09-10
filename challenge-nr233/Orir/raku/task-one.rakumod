unit module Orir::raku::task-one:ver<0.0.1>:auth<Orir@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/Orir/raku/ -- test/challenge-nr233/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-one --user=Orir --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
#our sub solution( List:D[Alpha:D] $words --> List:D[APair:D] ) is export {
our sub solution(@a --> Int) is export {
    my $i = 3;
    my @p = 0,0,1,3, -> $a { $a+$i++} … ∞;
    my @c = @a.map( *.split('', :skip-empty).unique.sort);
    my %h;
    for @c { quietly %h{$_}++  }
    sum @p[%h.values];
}