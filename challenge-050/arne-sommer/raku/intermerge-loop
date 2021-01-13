#! /usr/bin/env raku

unit sub MAIN (Str $intervals = '[2,7], [3,9], [10,12], [15,19], [18,22]', :$verbose);

sub from ($interval)
{
  $interval ~~ /^\[(\d+)\,\d+\]$/ || die "Not a legal interval";
  return $0.Int;
}

sub from-to ($interval)
{
  $interval ~~ /^\[(\d+)\,(\d+)\]$/ || die "Not a legal interval";
  return $0.Int, $1.Int;
}

my @intervals = $intervals.split(/\,\s+/).sort( &from );

say ": @intervals[]" if $verbose;

my ($from, $to) = from-to(@intervals.shift);

while @intervals
{
  my ($new-from, $new-to) = from-to(@intervals.shift);
  if $new-from <= $to +1
  {
    $to = $new-to if $new-to > $to;
  }
  else
  {
    print "[$from,$to], ";
    $from = $new-from;
    $to   = $new-to;
  }
}

say "[$from,$to]";
