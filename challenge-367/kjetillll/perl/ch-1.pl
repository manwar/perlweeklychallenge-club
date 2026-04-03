sub f {
    (
     join '',
     reverse
     sort
     $_[0]
     =~ s/1//r
     =~ /./g
    )
    . 1
}

print f( $$_[0]) eq $$_[1] ? "ok\n" : "ERROR\n" for
    [ "1011" =>  "1101" ],
    [ "100" =>  "001" ],
    [ "111000" =>  "110001" ],
    [ "0101" =>  "1001" ],
    [ "1111" =>  "1111" ];

# https://theweeklychallenge.org/blog/perl-weekly-challenge-367/
