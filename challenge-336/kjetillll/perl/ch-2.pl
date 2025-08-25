sub f {
    my @s;
    for( @_ ) {
        if   ( /-?\d+/ ){ push @s, $_              }
        elsif( /\+/    ){ push @s, $s[-2] + $s[-1] }
        elsif( /C/     ){ pop  @s                  }
        elsif( /D/     ){ push @s, 2 * $s[-1]      }
        else            { die "Invalid element $_" }
    }
    eval join '+', @s
}

print f( $$_[0] =~ /\S+/g ) == $$_[1] ? "ok\n" : "error\n" for
[ '5 2 C D +'              =>   30 ],
[ '5 -2 4 C D 9 + +'       =>   27 ],
[ '7 D D C + 3'            =>   45 ],
[ '-5 -10 + D C +'         =>  -55 ],
[ '3 6 + D C 8 + D -2 C +' =>  128 ]
