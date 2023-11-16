my @p1 = (1, 3, 2, 3, 1);
my @p2 = (2, 4, 3, 5, 1);

sub reverse-pair (@a) {
  #A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
  for @a.keys.combinations(2).map( *.sort.cache ).unique.cache {
    if @a[ .head ] > 2 * @a[ .tail ] {
      say "({ .head }, { .tail }) => num[{ .head }] ({ @a[ .head ] }) = {
             @a[.head ] } > 2 * num[{ .tail }] ({ @a[ .tail ] })";
    }
  }
  say '-' x 40;
}

reverse-pair( @p1 );
reverse-pair( @p2 );
