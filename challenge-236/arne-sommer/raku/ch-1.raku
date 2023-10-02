#! /usr/bin/env raku

unit sub MAIN (*@bills where all(@bills) ~~ Int && all(@bills) == any(<5 10 20>), :v(:$verbose));

my $cash        = BagHash.new();
my $transaction = 0;

for @bills -> $bill
{
  my $change = $bill - 5;
  print ":Transaction { ++$transaction } | Payment: $bill | Change: $change" if $verbose;
  $cash{$bill}++;

  if $change
  {
    for $cash.keys.sort.reverse -> $note
    {
      while $change >= $note && $cash{$note}
      {
        $cash{$note}--;
        $change -= $note;
      }
    }
  }

  if $change
  {
    say " | Unable to give change" if $verbose;
    say 'false';
    exit;
  }

  say " | Cash Register: { $cash.kxxv.sort.join(",") }" if $verbose;
}

say "true";
