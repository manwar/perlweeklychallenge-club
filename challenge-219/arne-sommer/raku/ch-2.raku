#! /usr/bin/env raku

unit sub MAIN ($costs, $days, :v(:$verbose));

my @costs = $costs.words>>.Numeric;

die "Specify three costs" unless @costs.elems == 3;
die "Costs must be numeric" unless all(@costs) ~~ Numeric;

my %costs = ( 1 => @costs[0], 7 => @costs[1], 30 => @costs[2] ); 

my @days  = $days.words>>.UInt;

die "The days must be positive integers (1..366)" unless all(@days) ~~ UInt && 1 <= all(@days) <= 366;

my @res = gather
{
  recurse(log => (), total-cost => 0, todo => @days.sort);
}

my $lowest = Inf;

for @res -> $row
{
  print ": Cost: $row{'cost'}" if $verbose;

  if $row{'cost'} < $lowest
  {
    $lowest = $row{'cost'};
    say " - new lowest" if $verbose;
  }
  elsif $verbose
  {
    say "";
  }

  if $verbose
  {
    for @($row{'log'}) -> $log
    {
      say ": - $log";
    }
    say "";
  }
}

say $lowest;

sub recurse (:@log, :$total-cost, :@todo is copy)
{
  my $today = @todo.shift;

  for 1,7,30 -> $days
  {
    my $paid     = $total-cost + %costs{$days};
    my $paid-to  = $today + $days;
    my @covered  = ($today,);
    my @new-todo = @todo.clone;
    my @new-log  = @log.clone;

    while @new-todo.elems && @new-todo[0] < $paid-to
    {
      @covered.push: @new-todo.shift;
    }

    @new-log.push: "At day $today pay for $days day(s) ({ @covered.join(",") })";

    if @new-todo.elems
    {
      recurse(log => @new-log, total-cost => $paid, todo => @new-todo)
    }
    else
    {
      take { cost => $paid, log => @new-log };
    }
  }
}
