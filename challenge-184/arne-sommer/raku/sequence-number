#! /usr/bin/env raku

my @list1 = ('ab1234', 'cd5678', 'ef1342');
my @list2 = ('pq1122', 'rs3334');

say sequence-number(@list1);
say sequence-number(@list2);

sub sequence-number (@list)
{
  my @return;

  for @list -> $string
  {
    state $count = 0;

    @return.push($count.fmt('%02d') ~ $string.substr(2,4));
    $count++;
  }

  return @return;
}
