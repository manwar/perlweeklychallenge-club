# Where A,B,C,D are all pentagonal numbers:
# B + C == A      ,  B - C == D     Original problem statement in task 
#     C == A - B  ,  B - C == D     Rearranged as two differences
#     C == A - B  ,  B-(A-B)==D     Rearranged as two differences(C,D), expressed only in A,B
# So, if we find any two pentagonal numbers A,B where A-B is pentagonal and B-(A-B) is pentagonal,
# then we have a solution. The desired numbers will be the inner two: (B,C)
sub find-first-plus-and-minus-pentagon_numbers ( ) {
    constant @pents = map ->\n { n *(3*n - 1) div 2 }, 1..*;

    my %p;
    for @pents.kv -> \i, \A {
        %p{A} = 1;

        for @pents.head(i) -> \B {
            my \D = A - B;
            my \C = B - D;
            return B, C if %p{C} and %p{D};
        }
    }
}
put find-first-plus-and-minus-pentagon_numbers();
