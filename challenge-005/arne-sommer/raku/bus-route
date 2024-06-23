#! /usr/bin/env raku

unit sub MAIN (Str $routestr = "12 11 41 | 15 5 35", :v(:$verbose)); 

my @routes = $routestr.split("|")>>.words>>.Numeric;

die "All the routes must have three integers each" unless all(@routes>>.elems) == 3;
die "Non-negative integers only" unless all(@routes[*;*]) ~~ UInt;

my @departures;

for @routes -> @route
{
  state $rid   = 0; $rid++;
  my $interval = @route[0];
  my $offset   = @route[1];
  my $duration = @route[2];

  say ": Route: $rid Interval: $interval Offset: $offset Duration: $duration" if $verbose;

  die "Route $rid: Interval does not comply with 60 min rule" unless 60 %% $interval;
  die "Route $rid: Interval must be positive" unless $interval > 0;

  my $min = $offset;

  while $min < 60
  {
    @departures.push: { dept => $min, route => $rid, arrival => $min + $duration };

    $min += $interval;
  }
}

my @sorted = @departures.sort({ $^a<dept> <=> $^b<dept> || $^a<arrival> <=> $^b<arrival> || $^a<route> <=> $^b<route> });

if $verbose
{
  for @sorted -> %dep
  {
    say ": Departure at { %dep<dept>.fmt('%02d') }: route %dep<route> arrive at %dep<arrival>";
  }
}

exit if $verbose && $verbose eq '2';

my @skip;

for 0 .. 59 -> $min
{
  my @todo = @sorted.grep( *<dept> >= $min );

  unless @todo.elems
  {
    if @skip && @skip[0] == 0
    {
      @skip.push: $min;
      say ": Min:$min (no more departures this hour, and we skipped the first one this hour) * skip" if $verbose;
    }
    elsif $verbose
    {
      say ": Min:$min (no more departures this hour, and we took the first one this hour) - first";
    }
    next;
  }

  my %first   = @todo.shift;
  my %wait_to = %first;

  for @todo -> %dept
  {
    %wait_to = %dept if %dept<arrival> < %wait_to<arrival>;
  }

  my $ok = %first eqv %wait_to;

  @skip.push: $min if !$ok;
  say ": Min:{ $min.fmt('%02d') }: { $min == %wait_to<dept> ?? "" !! "wait to %wait_to<dept>" } take route %wait_to<route> and arrive at %wait_to<arrival> { $ok ?? "- first" !! "* skip" }" if $verbose;
}

say "[{ @skip.join(", ") }]";
