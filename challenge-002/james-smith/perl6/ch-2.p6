sub mp($n)  {chr $n+($n < 10??48!!55)}
sub mb($n)  {(ord $n)-($n ~~ /\d/ ?? 48 !! 55)}
sub to_base($r,$n){$n??to_base($r,floor $n/$r)~mp($n%$r)!!''}
sub from_base($r,$n){$n??from_base($r,substr $n,0,*-1)*$r+mb(substr $n,*-1)!!0}
sub convert($from,$to,$n){to_base($to,from_base($from,$n))}
my &to_35  = &to_base.assuming(35);
my &fr_35  = &from_base.assuming(35);
my &hx2b35 = &convert.assuming(16).assuming(35);

say to_35       $_ for @*ARGS;
say fr_35 to_35 $_ for @*ARGS;
say hx2b35      $_.fmt('%X') for @*ARGS;
