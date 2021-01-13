#Definitely not optimized. Will be extremely slow for large numbers 
($m,$n)=@ARGV;
($x,$y)=(~~$m,~~$n);
$r=()=(1x$m)=~/1{$y}/g;
$y&&print$m<0^$n<0?-$r:$r;