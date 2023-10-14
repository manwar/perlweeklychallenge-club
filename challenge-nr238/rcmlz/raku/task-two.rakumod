unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr238/rcmlz/raku/ -- test/challenge-nr238/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr238 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr238; cat /tmp/nr238_task-two.csv

#|[
You are given an array of positive integers.

- Write a script to sort the given array in increasing order with respect to the count of steps required to obtain a single-digit number by multiplying its digits recursively for each array element. 

If any two numbers have the same count of steps, then print the smaller number first.

Input: @int = (15, 99, 1, 34)
Output: (1, 15, 34, 99)

15 => 1 x 5 => 5 (1 step)
99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
1  => 0 step
34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
]
our sub solution(@input) is export {
    sort &persistence-order, @input 
}

sub split-and-multiply(UInt $x --> UInt){
    return 0 if $x < 10;
    my $r = [*] $x.Str.comb.map: *.UInt;
    1 + samewith($r)
}

sub persistence-order(UInt $a, UInt $b --> Order){
    my ($x, $y) of UInt = ($a, $b).map: *.&split-and-multiply;
    my Order $ord = $x cmp $y;
    $ord eqv Same ?? $a cmp $b !! $ord
}
