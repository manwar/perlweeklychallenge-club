module tests;

import ch2;

fn void arrange_box_test() @test
{
  assert(ch2::arrange_box(tmem,{{1,3},{3,5},{6,8},{2,4}}) == 4);
  assert(ch2::arrange_box(tmem,{{4,5},{4,6},{6,7},{2,3},{4,3}}) == 3);
  assert(ch2::arrange_box(tmem,{{5,5},{5,5},{5,5}}) == 1);
  assert(ch2::arrange_box(tmem,{{2,100},{3,200},{4,300},
    {5,50},{5,400}}) == 4);
  assert(ch2::arrange_box(tmem,{{10,20},{15,10},
    {20,30},{12,18},{16,25}}) == 3);
}

