module tests;

import ch1;

fn void array_median_test() @test
{
  assert(ch1::array_median(tmem,{2},{4}) == 3.0);
  assert(ch1::array_median(tmem,{1,2,3},{7,8,9,10}) == 7.0);
  assert(ch1::array_median(tmem,{},{10,20,30,40}) == 25.0);
  assert(ch1::array_median(tmem,{100},{1,2,3,4,5,6,7}) == 4.5);
  assert(ch1::array_median(tmem,{1,2,2},{2,2,3}) == 2.0);
}

