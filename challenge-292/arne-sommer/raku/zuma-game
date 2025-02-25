#! /usr/bin/env raku

subset BALLS of Str where { /^ (<[A .. Z]>)+ $/ };

unit sub MAIN ($row  where $row  ~~ BALLS,
               $hand where $hand ~~ BALLS,
               :v(:$verbose));

my $row-bag  = $row.comb.BagHash;
my $hand-bag = $hand.comb.BagHash;
my @row      = tokenizer($row);
my $count    = 0;

while @row.elems
{
  my @new;

  if $verbose
  {
    say ": Row (grouped): @row[]"; 
    say ": Row (bag): $row-bag";
    say ": Hand (bag): $hand-bag";
  }

  my $count-inner = 0;

  for @row -> $elem
  {
    my $length = $elem.chars;
    my $char   = $elem.substr(0,1);
    if $length == get_count($char) && $length + get_hand($char) >= 3
    {
      say ": * Remove $elem ($length)" if $verbose;
      
      $row-bag{$char} = 0;
      my $add = $length < 3 ??  (3 - $length) !! 0;
      $hand-bag{$char} -= $add;

      $count += $add;
      $count-inner++;

      if $verbose
      {
        say ": * Remove $elem ($length from row + $add from hand)";
        say ":   Row (bag): $row-bag";
        say ":   Hand (bag): $hand-bag";
      }

    }
    else
    {
      say ": + Keep $elem" if $verbose;
      @new.push: $elem;
    }
  }

  last if @new.elems == 0;

  if $count-inner == 0
  {
    say -1;
    exit;
  }

  @row = tokenizer(@new.join);
}  

say $count;

sub get_count ($char)
{
  return $row-bag{$char};
}

sub get_hand ($char)
{
  return $hand-bag{$char};
}

sub tokenizer ($str)
{
  return gather
  {
    my @chars = $str.comb;
    my $first = @chars.shift;
    my $count = 1;

    while @chars
    {
      my $second = @chars.shift;
      if $first ne $second
      {
        take $first x $count;
        $first = $second;
        $count = 1;
      }
      else
      {
        $count++;
      }
    }

    take $first x $count;
  }
}
