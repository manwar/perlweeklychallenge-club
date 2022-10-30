#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

say dip( (4, 5, 1, 6), 2);
say dip( (1, 2, 3, 4), 2);
say dip( (1, 3, 4, 5), 3);
say dip( (5, 1, 2, 3), 4);
say dip( (7, 2, 4, 5), 4);

sub dip (@list, $k)
{
  my @combinations = @list.combinations(2);
  my $n            = @list.elems;
  my $count        = 0;

  say ":I :[{ @list.join(",") }] K:$k N:$n" if $verbose;

  for @combinations -> @candidate
  {
    my ($i, $j) = @candidate;

    ($i, $j) = ($j, $i) if $i > $j;

    say ":Comb :[$i,$j]" if $verbose;

    next unless 0 <= $i < $j < $n;
    say ":Less :[$i,$j] -> { @list[$i] },{ @list[$j] }" if $verbose;
    next unless (@list[$i] + @list[$j]) %% $k;

    $count++;
    say ":OK   :[{ @candidate.join(",") }] | $count" if $verbose;

  }

  return $count;
}
