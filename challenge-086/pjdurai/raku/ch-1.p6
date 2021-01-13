use Test;

sub solve(@N, $A){
    for @N.combinations: 2 -> @pair {
        return 1 if abs(@pair[0] - @pair[1]) == $A
    }
    return 0;
}

multi MAIN(){
    ok solve((1, 5, 2, 9, 7), 6) == 1, "(1, 5, 2, 9, 7), 6) -> 1";
    ok solve((10, 8, 12, 15, 5), 7 ) == 1, "(10, 8, 12, 15, 5), 7 ) -> 1";
    ok solve((10, 30, 20, 50, 40), 15) == 0, "(10, 30, 20, 50, 40), 15) -> 0 ";
}
