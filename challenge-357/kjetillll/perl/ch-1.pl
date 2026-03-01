sub f {
    my($n, $step) = @_;
    my @d = sort split //, $n = sprintf "%04d", abs $n;
    $n == 0    ? -1
   :$n == 6174 ? $step
   :f( join('',reverse @d) - join('',@d), $step+1 )
}
print f($$_[0]) == $$_[1] ? "ok\n" : "ERROR\n" for 
[ 3524 => 3],
[ 6174 => 0],
[ 9998 => 5],
[ 1001 => 4],
[ 9000 => 4],
[ 1111 => -1],
