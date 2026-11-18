module ch1_test;

import ch1;

fn void largest_interval_test() @test
{
  test::eq(2,ch1::largest_interval(20));
  test::eq(4,ch1::largest_interval(110));
  test::eq(11,ch1::largest_interval(500));
  test::eq(105,ch1::largest_interval(2026));
  test::eq(105,ch1::largest_interval(10000));
}

