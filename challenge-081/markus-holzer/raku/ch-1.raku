unit sub MAIN( Str $A, $B where $B.chars > $A.chars );

# Custom operator, just for fun
multi sub infix:<%%>( Str $n, Str $d ) {
    $n eq $d x $n.chars div $d.chars }

.say for grep $B %% *, [\~] $A.comb