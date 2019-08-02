#! /usr/bin/env perl6

unit sub MAIN (*@values);

say "Standard Ranking: ", std-ranking(@values).join(", ");
say "Modified Ranking: ", modified-ranking(@values).join(", ");
say "Dense    Ranking: ", dense-ranking(@values).join(", ");

sub std-ranking(@values)
{
  my $count = @values.Bag;
  my %rankings;
  my $current-ranking = 1;

  for $count.keys.sort
  {
    %rankings{$_} = $current-ranking;
    $current-ranking += $count{$_};
  }
  return @values.map({ %rankings{$_} });
  # my @return; @return.push(%rankings{$_}) for @values; return @return
}

sub modified-ranking(@values)
{
  my $count = @values.Bag;
  my %rankings;
  my $current-ranking = 0;

  for $count.keys.sort
  {
    $current-ranking += $count{$_};
    %rankings{$_} = $current-ranking;
  }

  return @values.map({ %rankings{$_} });
}

sub dense-ranking(@values)
{
  my $set = @values.Set;
  my %rankings;
  my $current-ranking = 0;

  %rankings{$_} = ++$current-ranking for $set.keys.sort;

  return @values.map({ %rankings{$_} });
}
