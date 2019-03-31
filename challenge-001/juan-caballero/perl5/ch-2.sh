perl -e 'for $n (1..20){ $s=$n; $s="fizz" if($n%3==0); $s="buzz" if($n%5==0); $s="fizz buzz" if($n%3==0)and($n%5==0); print "$s\n";}'
