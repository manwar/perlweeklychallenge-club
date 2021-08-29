#! /usr/bin/env raku

unit sub MAIN (Str $interval = '1 4 | 3 5 | 6 8 | 12 13 | 3 20', :v(:$verbose));

my @Intervals = $interval.split("|")>>.words>>.Int;

class interval
{
  has Int $.from;
  has Int $.to;

  method does-intersect(interval $interval)
  {
    return False if $.to < $interval.from;
    return False if $interval.to < $.from;
    return True;
  }

  method Str
  {
    return "($.from,$.to)";
  }
}

my @done;
my @conflict;

for @Intervals -> $interval
{
  say ": Generating interval: @$interval[0] -> @$interval[1]" if $verbose;
  
  my $i = interval.new(from => @$interval[0], to => @$interval[1]);

  for @done -> $iv
  {
    if $i.does-intersect($iv)
    {
      @conflict.push: $i;
      last;
    }
  }

  @done.push: $i;
} 

say '[ ', @conflict.join(", "), ' ]';
