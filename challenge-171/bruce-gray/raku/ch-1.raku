use Prime::Factor;

constant @abundant_odd = grep { .&proper-divisors.sum > $_ }, (1, 3, 5 … Inf);

say @abundant_odd.head(20);



# https://oeis.org/A005231
constant @A005231 = 945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985, 6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925, 9135, 9555, 9765, 10395, 11025, 11655, 12285, 12705, 12915, 13545, 14175, 14805, 15015, 15435, 16065, 16695, 17325, 17955;
warn unless @abundant_odd.head(+@A005231) eqv @A005231.Seq;
