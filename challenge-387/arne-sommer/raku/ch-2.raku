#! /usr/bin/env raku

unit sub MAIN (Str $formula, :v(:$verbose));

my @stack = ({},);
my $i     = 0;

while $i < $formula.chars
{
  my $ch = $formula.substr($i, 1);

  if $ch eq '('
  {
    @stack.push({});
    $i++
  }
  elsif $ch eq ')'
  {
    my %group = @stack.pop;
    $i++;
    my $mult  = 0;

    while $i < $formula.chars && $formula.substr($i, 1) ~~ /\d/
    {
      $mult = $mult * 10 + $formula.substr($i, 1).Int;
      $i++
    }

    $mult = 1 unless $mult;

    for %group.kv -> $k, $v
    {
      @stack[*-1]{$k} += $v * $mult;
    }
  }
  else
  {
    my $elem = $ch;
    $i++;

    while $i < $formula.chars && $formula.substr($i, 1) ~~ /<[a..z]>/
    {
      $elem ~= $formula.substr($i, 1);
      $i++
    }

    my $count = 0;
    while $i < $formula.chars && $formula.substr($i, 1) ~~ /\d/
    {
      $count = $count * 10 + $formula.substr($i, 1).Int;
      $i++
    }

    $count = 1 unless $count;
    @stack[*-1]{$elem} += $count;
  }
}

my %final = @stack[0];

say %final.keys.sort.map({ ~$_ ~ (%final{$_} > 1 ?? %final{$_} !! '') }).join;
