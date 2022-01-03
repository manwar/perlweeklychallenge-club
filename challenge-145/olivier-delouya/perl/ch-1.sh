dot_product='@a=eval($a); @b=eval($b); for($i=0, $dot_product=0, $N=scalar(@a); $i<$N; $i++) { $dot_product += $a[$i]*$b[$i]; }; print $dot_product;'

perl -se "$dot_product" -- -a="(1,2,3)" -b="(4,5,6)"
