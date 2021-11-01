#!/Applications/Rakudo/bin/raku
#
#
#       a-series-of-lies.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $target = 30034 ) ;

## generate list of Fib numbers from second index up to but not including the index
## of the first value exceeding the target
my @fibs        = (1, 1, * + * ... *);
my @unique_fibs = @fibs[1..^@fibs.first(* > $target, :k)];

say qq:to/END/;
    found {@unique_fibs.elems} Fibonacci numbers less than $target
    there are { 2 ** @unique_fibs.elems - 1 } comnbinations to be processed
    calculating...
    END
 
## compute all combinations for all lengths
my @out;
for (@unique_fibs.combinations($_) for 1..@unique_fibs.elems) {
    for $_ -> $c {
        push @out, $c.join( ' + ') if $c.sum == $target;
    }
}
    
say "found {@out.elems} solutions";
.say for @out;

