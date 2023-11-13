unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

use Prime::Factor;

# run in terminal: raku --optimize=3 -I challenge-nr241/rcmlz/raku/ -- test/challenge-nr241/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr241 -- test/benchmark-scalability.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr241; cat /tmp/nr241_task-two.csv

#|[
You are given an array of unique positive integers greater than 2.

- Write a script to sort them in ascending order of the count of their prime factors, tie-breaking by ascending value.
]
our sub solution(@input) is export {
    @input ==> map( -> $n { $n => prime-factors($n).elems } ) 
           ==> sort(      { my Order $o = $^a.value cmp $^b.value; 
                            $o == Same ?? $^a.key cmp $^b.key !! $o } )
           ==> map( *.key )
}