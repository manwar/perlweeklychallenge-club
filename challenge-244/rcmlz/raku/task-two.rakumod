unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr244/rcmlz/raku/ -- test/challenge-nr244/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr244 -- test/benchmark-scalability.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr244; cat /tmp/nr244_task-two.csv

#|[
You are given an array of integers representing the strength.
- Write a script to return the sum of the powers of all possible combinations; 
- power is defined as the square of the largest number in a sequence, multiplied by the smallest.
]
our sub solution(@input) is export {
    
    my @sorted = @input.sort({$^b cmp $^a});
    my $n = @sorted.elems;

    # how many sets exists in power-set with max/min
    my @multiplicators = 1,2,4,8 ... $n;

    my @sets;

    for ^($n - 1) -> $i {
        @sets.push: @sorted[$i]² * ([+] @sorted[$i+1 .. *-1] »*» @multiplicators)
    }

    # single element sets +  multi elements sets
    ([+] @sorted.map: *³) + [+] @sets
}

our sub solution-simple-but-slow(@input) is export {
    [+] @input.combinations
              .race(batch => 2**15, degree => Kernel.cpu-cores)
              .map( { .elems ?? .min * .max**2 !! 0 } )
}