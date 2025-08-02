# Perl 4.019 on DOSBOX

sub three_power {
 local( $n )=@_;
 $n=($n**(1/3));
 $n==sprintf("%d",$n);
}
print &three_power(27),"\n"; #1
print &three_power(0),"\n"; #1
print &three_power(6),"\n"; #0
