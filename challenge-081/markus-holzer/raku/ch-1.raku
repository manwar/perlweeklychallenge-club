unit sub MAIN( Str, Str );

my Str $A = @*ARGS.min(*.chars);
my Str $B = @*ARGS.max(*.chars);

# Custom operator, just for fun
multi sub infix:<%%>( Str $n, Str $d ) returns Bool {
    #will always be a Rat
    given $n.chars / $d.chars {
        .denominator == 1
            ?? $n eq $d x $_
            !! False }}

.say for grep all($A, $B) %% *, [\~] $A.comb