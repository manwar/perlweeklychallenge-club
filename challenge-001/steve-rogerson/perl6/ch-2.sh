perl6 -e 'for  1..20 { my $x = !($_ % 3) + 2*!($_%5);  if ($x ==0) {print $_}
else {if ($x +& 1) {print "Fizz"}; if ($x +& 2) {print "Buzz"}};  say ""}'

