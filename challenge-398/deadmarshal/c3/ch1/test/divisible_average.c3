module divisible_average;

import ch1;

fn void divisible_average_test() @test
{
  assert(ch1::divisible_average({18,5,7,11}) == 18);
  assert(ch1::divisible_average({6,12,18,24,30,40}) == 18);
  assert(ch1::divisible_average({3,9,15,21,27}) == 0);
  assert(ch1::divisible_average({6,12,14,20}) == 9);
  assert(ch1::divisible_average({6,6,6,12,12}) == 8);
}

