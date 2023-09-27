unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr236/rcmlz/raku/ -- test/challenge-nr236/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr236 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr236; cat /tmp/nr236_task-two.csv

#|[
You are given an array of unique integers.

- Write a script to determine how many loops are in the given array.
- To determine a loop: Start at an index and take the number at array[index]
  and then proceed to that index and continue this until you end up at the starting index.
]
our sub solution(@input) is export {
    my %graph = @input.pairs;
    my $cycles = 0;

    while %graph.keys.elems {
        
        $cycles = $cycles + %graph.grep( -> $entry {$entry.key == $entry.value} );

        %graph = %graph.grep( -> $entry {$entry.key != $entry.value} );        

        my $untouched = %graph.keys.Set;

        for %graph.kv -> $k, $v {
            if %graph{$v}:exists {
                %graph{$k} = %graph{$v};
                $untouched = $untouched ∖ $k;
            }
        }

        %graph{$_}:delete for $untouched.keys;
    }

    return $cycles;
}