unit module luca-ferrari::raku::task-two:ver<0.0.1>:auth<github:luca-ferrari>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/luca-ferrari/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=luca-ferrari --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@words]) is export {
    my @allowed;
    for @words -> $current-word {
    my $found = True;

    for $current-word.comb -> $current-char {
        $found = False and last if ( ! $allowed.comb.grep( * ~~ $current-char ) );
    }

    @allowed.push: $current-word if ( $found );
    }

    @allowed.elems;
}