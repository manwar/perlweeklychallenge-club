multi MAIN(UInt $N where * > 0) {
    say uint-log($N)
}

multi MAIN {
    use Test;
    plan 9;

    my @pairs = 1        => 1,   
                2        => 0,      
                8        => 1,       
                15       => 0, 
                125      => 1, 
                126      => 0, 
                1024*8   => 1, 
                1024*8+1 => 0,
                2**33    => 1;

    for @pairs -> $pair {
        ok uint-log($pair.key) == $pair.value, $pair.fmt("%10d --> %d")
    }
}
    
sub uint-log(UInt $N) {    
    return 1 if $N == 1;

    (2..$N.sqrt.floor).map({ $N.log: $_ })
                      .first({ .narrow ~~ UInt })
                      .Bool
                      .UInt;
}
