#! /usr/bin/env raku

multi sub MAIN ($range where ($range ~~ /(\d+)\.\.(\d+)/ && $0 < $1),
                Int :$N, :v(:$verbose))
{
  $range ~~ /(\d+)\.\.(\d+)/;
  MAIN($0.Int .. $1.Int, :$N, :$verbose);
}

multi sub MAIN ($sequence where ($sequence ~~ /(\d+)\,(\d+)\.\.\.(\d+)/ && $0 < $1 < $2),
                Int :$N, :v(:$verbose))
{
  $sequence ~~ /(\d+)\,(\d+)\.\.\.(\d+)/;
  MAIN(($0.Int, $1.Int ... $2.Int).eager, :$N, :$verbose);
}

multi sub MAIN (*@N where (@N.elems && all(@N) ~~ Int && [<] @N),
                Int :$N, :v(:$verbose))
{
  say ': @N: ', @N.join(',') if $verbose;
  
  my $end = @N.end;

  my $delta = ($end/2).round;
  my $try   = $delta;

  loop
  {
    say ": try at $try" if $verbose;

    if $try == 0 && $N < @N[0]
    {
      say 0;
      last;
    }
    elsif $try == $end && $N > @N[$end]
    {
      say $end +1;
      last;
    }
  
    if @N[$try] == $N
    {
      say $try;
      last;
    }
    elsif @N[$try] < $N && @N[$try+1] > $N
    {
      say $try +1;
      last;
    }

    $delta = ($delta/2).round;

    if @N[$try] < $N
    {
      $try += $delta;
    }
    elsif @N[$try] > $N
    {
      $try -= $delta;
    }
  }
}
