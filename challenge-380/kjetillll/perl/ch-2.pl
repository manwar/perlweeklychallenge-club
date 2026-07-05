sub f {
    my($str, $sum, $pos) = (@_, 0, 1);

    $str !~ s/.//
    ? $sum
    : f( $str,
         $sum + $pos * (123 - ord $&), #(a=26, z=1)
         $pos + 1 )
}

print f( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "z"       =>    1 ],
[ "a"       =>   26 ],
[ "bbc"     =>  147 ],
[ "racecar" =>  560 ],
[ "zyx"     =>   14 ],
