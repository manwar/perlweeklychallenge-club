sub mp($n)  {chr $n+($n < 10??48!!55)}
sub b35($n) {$n??b35(floor $n/35)~mp($n%35)!!''}
say b35 $_ for @*ARGS;
