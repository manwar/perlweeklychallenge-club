
sub f {
    my($str, $at, $sec) = (@_, 'a', 0);
    my $dist = sub { my($a, $b) = map ord, sort @_; $b-$a > 13 ? 26-$b+$a : $b-$a };
    !$str ? $sec : f( $str=~s/.//r, $&, 1 + $sec + &$dist( $at => $& ) )
}

print f($$_[0]) == $$_[1] ? "ok\n" : "err\n" for
[ "abc"  => 5 ],
[ "bza"  => 7 ],
[ "zjpc" => 34 ],
[ "zjjpcc" => 36 ],
[ "am" => 1+1+12 ],
[ "an" => 1+1+13 ],
[ "ao" => 1+1+12 ],
