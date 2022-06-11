sub is_factorion ( UInt $n --> Bool ) {
    constant @factorials = 1, |[\*] 1..*;
    return $n == @factorials[$n.comb].sum;
}

put (145,123).map:  &is_factorion;
put (^41_000).grep: &is_factorion;

# Output:
#   True False
#   1 2 145 40585
