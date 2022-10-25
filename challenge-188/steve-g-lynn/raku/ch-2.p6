#!/usr/bin/env perl6

say &total-zero(5,4); #5
say &total-zero(6,4); #3
say &total-zero(5,2); #4
say &total-zero(3,1); #3
say &total-zero(7,4); #5

multi sub total-zero( UInt $bigger, UInt $smaller where $bigger==$smaller ) {
    return 1;
}

multi sub total-zero( UInt $bigger, UInt $smaller where ($bigger > $smaller) && ($smaller == 1) ) {
    return $bigger;
}

multi sub total-zero( UInt $bigger, UInt $smaller where ($bigger > $smaller) && ($smaller > 1) && ($bigger %% $smaller) ) {
    return Int($bigger/$smaller);
}


multi sub total-zero( UInt $bigger, UInt $smaller where ($bigger > $smaller) && ($smaller > 1) && ($bigger % $smaller > 0)) {
    my $times=Int($bigger/$smaller);
    return $times + total-zero($smaller, $bigger-$times*$smaller);
}

