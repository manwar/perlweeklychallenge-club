use v6;

subset Three-digits of Int where 99 < * < 1000;

multi sub prefix:<dif1> (List $val) {
    abs($val[0] - $val[1]) == 1 ?? True !! False;
}

sub MAIN (Three-digits $start is copy, Three-digits $end is copy) {
    ($start, $end) = ($end, $start) if $start > $end;

    for $start..$end -> $num {
        my $flag = True;
        for $num.comb.rotor: 2 => -1 -> $seq {
            $flag = False unless dif1 $seq;
        }
        say "$num is a stepping number." if $flag;
    }
}
