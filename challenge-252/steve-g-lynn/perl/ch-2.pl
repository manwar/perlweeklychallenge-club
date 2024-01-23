#perl 4.019 on DOSBOX

sub unique_sum_zero {
 local($n)=@_;
 local(@retval)=();
 ($n % 2) && push( @retval, 0);
 local ($i);
 for $i (1 .. ($n/2)) {
  push( @retval,(-$i, $i) );
 }
 @retval;
}

print join(',',&unique_sum_zero(5)),"\n"; #0,-1,1,-2,2
print join(',',&unique_sum_zero(3)),"\n"; #0,-1,1
print join(',',&unique_sum_zero(1)),"\n"; #0
