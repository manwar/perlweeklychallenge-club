unit sub MAIN( Str, Str );

my Str $A = @*ARGS.min;
my Str $B = @*ARGS.max;

# Custom operator, just for fun
multi sub infix:<%%>( Str $n, Str $d ) {
    $n eq $d x $n.chars div $d.chars }

.say for grep $B %% *, [\~] $A.comb