sub f {
    my $str = shift;
    my $spaces = $str =~ s/ / /g;
    my @words = $str =~ /\S+/g;
    my $gaps = @words - 1 || 9e9;
    join( ' ' x ( $spaces / $gaps ), @words )
    . ' ' x ( $spaces % $gaps );
}

print f($$_[0]) eq $$_[1] ? "ok\n" : "ERROR\n" for
    [ "  challenge  "                =>  "challenge    "               ],
    [ "coding  is  fun"              =>  "coding  is  fun"             ],
    [ "a b c  d"                     =>  "a b c d "                    ],
    [ "  team      pwc  "            =>  "team          pwc"           ],
    [ "   the  weekly  challenge  "  =>  "the    weekly    challenge " ],
