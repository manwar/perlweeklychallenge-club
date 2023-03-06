#! /usr/bin/env raku

unit sub MAIN (*@time where @time.elems >= 2 && all(@time) ~~ /^<[012]><[0..9]>\:<[0..5]><[0..9]>$/, :v($verbose));

class HHMM
{
  has UInt $.hh is rw where 0 <= $_ <= 23;
  has UInt $.mm is rw where 0 <= $_ <= 59;

  method minutes
  {
    return $.hh * 60 + $.mm;
  }

  method diff (HHMM $second)
  {
    my $diff = $second.minutes - $.minutes;
    return 24 * 60 + $diff if $diff < 0;
    return $diff;
  }

  method Str
  {
    return $.hh.fmt('%02d') ~ ":" ~ $.mm.fmt('%02d');
  }
}

my @sorted = @time.sort.map({ HHMM.new(hh => $_.substr(0,2).UInt, mm => $_.substr(3,2).UInt) });

say ": Sorted: { @sorted.join(", ") }" if $verbose;

if (@sorted.elems > @sorted.unique.elems)
{
  say "0";
  exit;
}

@sorted.push: @sorted.head if @sorted.elems > 2;

say ": Sorted roundtrip: { @sorted.join(", ") }" if $verbose;

my $shortest = Inf;
my $first    = @sorted.shift;
my $second;

while (@sorted)
{
  my $second = @sorted.shift;
  my $diff   = $first.diff($second);

  $shortest = min($shortest, $diff);
  say ": first:$first second: $second -> diff:$diff" if $verbose;

  $first = $second;
}

say $shortest;
