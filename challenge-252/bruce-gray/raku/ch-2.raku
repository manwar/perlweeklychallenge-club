sub task2 ( UInt $n ) {
    return ($n - $n²) div 2, |( 1 ..^ $n );
}
sub matches_task_specification ( UInt $n, @got --> Bool ) {
    # Array of _$n_ _unique_ _integers_ that _sum_ to _zero_.
    return False if @got.elems    !== $n;
    return False if @got.repeated !== 0;
    return False if @got.any      !~~ Int;
    return False if @got.sum      !== 0;
    return True;
}


# Many solutions to every $n except $n==1,
# so we cannot use the output from the task examples.
### my @tests =
###     # Two other possible solutions could be as below: (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
###     ( 5, (-7, -1, 1, 3, 4) ),
###     ( 3, (-1, 0, 1) ),
###     ( 1, (0,) ),
### ;
use Test; plan 1;
constant $test_range = 1 .. 1_000;
my $fails = 0;
for $test_range -> $n {
    my @got = task2($n);
    if ! matches_task_specification($n, @got) {
        note "Failed: $n => @got[]";
        $fails++;
    }
}
is $fails, 0, "No failures when testing {$test_range.raku}";
