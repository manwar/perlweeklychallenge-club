#!/usr/bin/env raku
use Test;

# https://oeis.org/A000578/b000578.txt

ok  three-power(27);
ok  three-power(0);
nok three-power(6);
nok three-power(999400119991);
ok  three-power(999400119992);                          
nok three-power(999400119993);                          
is-deeply (^Inf).hyper(batch => 4096).grep(&three-power).skip(100).head(10), (1000000,
                                                                              1030301,
                                                                              1061208,
                                                                              1092727,
                                                                              1124864,
                                                                              1157625,
                                                                              1191016,
                                                                              1225043,
                                                                              1259712,
                                                                              1295029); 

sub three-power($n) 
{
    $n == exp(3, exp(1/3, $n).ceiling)
}
