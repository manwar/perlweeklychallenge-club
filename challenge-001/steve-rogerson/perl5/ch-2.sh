perl -E 'for $i (1..20){ $x = !($i % 3) + 2*!($i%5); if ($x ==0) {print $i}
else {if ($x &1) {print "Fizz"}; if ($x&2) {print "Buzz"}}; say}'

