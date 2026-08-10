sub f { join( '', map substr('usd', 1 + ( $_[$_-1] <=> $_[$_] ), 1), 1 .. $#_ ) =~ /^u+d+$/ } #usd=up same down

#-- tests
print pop(@$_) == f( @$_ ) ? "ok\n" : "ERROR\n" for
[ 1, 2, 3, 4, 5        => 0 ],   # false
[ 0, 2, 4, 6, 4, 2, 0  => 1 ],   # true
[ 5, 4, 3, 2, 1        => 0 ],   # false
[ 1, 3, 5, 5, 4, 2     => 0 ],   # false
[ 1, 3, 2              => 1 ],   # true
