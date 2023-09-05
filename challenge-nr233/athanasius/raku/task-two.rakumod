unit module challenge-nr233::athanasius::raku::task-two:ver<0.0.1>:auth<athanasius@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/athanasius/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ints) is export {
    &freq-sort( @ints );
}

sub freq-sort( List:D[Int:D] $ints --> List:D[Int:D] ){
    my UInt %freq{Int};
    ++%freq{ $_ } for @$ints;
    return ($ints.sort: { %freq{ $^a } leg %freq{ $^b } || $^b leg $^a }).list;
}