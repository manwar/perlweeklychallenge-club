perl -e 'foreach (1..20) { $str=$_; $str="fizz" if $_ % 3 == 0;
$str="buzz" if $_ % 5 == 0; $str="fizzbuzz" if $_ % 15 == 0; print
"$str\n" }'
