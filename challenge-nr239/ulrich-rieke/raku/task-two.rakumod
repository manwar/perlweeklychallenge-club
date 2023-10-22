unit module ulrich-rieke::raku::task-two:ver<0.0.1>:auth<github:ulrich-rieke>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/ulrich-rieke/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=ulrich-rieke --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@strings]) is export {

    my $allowedSet = Set.new( $allowed.comb ) ;
    my @consistent = @strings.grep( { myCondition( $_ , $allowedSet ) } ) ;
    @consistent.elems
}

sub myCondition( $aString is copy, $allowedSet ) {
    my $letterSet = $aString.comb.Set ;
    #the condition is fulfilled if the letterSet is a subset of allowedSet
    #or is equal to it
    return $letterSet (<=) $allowedSet ;
}
