#! /usr/bin/env raku

unit sub MAIN (:s(:$start),
               Int :o(:$offset) where $offset > 0 = 1,
	       :b(:$bank) = "",
               :v(:$verbose));

my $date = Date.new($start);

my %is-bank;

for $bank.words -> $bank
{
  %is-bank{Date.new($bank).Str} = True;
}

my $added = 0;
my $todo  = $offset;

loop
{
  if $date.day-of-week == 6|7
  {
    say ": Date $date ({ $date.day-of-week == 6 ?? 'Saturday' !! 'Sunday' }) Add 1" if $verbose;
    $date++;
    $added++;
  }
  elsif %is-bank{$date.Str}
  {
    say ": Date $date (Bank Holiday) Add 1" if $verbose;
    $date++;
    $added++;
  }
  elsif $todo
  {
    say ": Date $date (Todo { $todo }) Add 1" if $verbose;
    $date++;
    $added++;
    $todo--;
  }
  else
  {
    last;
  }
}

say ": Added a total of $added days" if $verbose;

say $date.Str;
