#! /usr/bin/env raku

subset Positive of Int where * > 0;

unit sub MAIN (*@custom, Bool :$clear, :$verbose, Positive :$boxcount = 1000000, Positive :$maxweight = 15, Positive :$duplicates = 1);

my %weight; %weight = (R => 1, B => 1, G => 2, Y => 12, P =>  4) unless $clear;
my %value;  %value  = (R => 1, B => 2, G => 2, Y =>  4, P => 10) unless $clear;

if @custom
{
  for @custom -> $current
  {
    if $current ~~ /^ (<upper>) [ w $<w> = (\d+) v $<v> = (\d+) |  v $<v> = (\d+) w $<w> = (\d+) ] $/
    {
      %weight{$0} = $<w>.Int;
      %value{$0}  = $<v>.Int;
      say "Added box $0 with weight $<w> kg and value £ $<v>" if $verbose;
    }
  }
}

my @boxes = %weight.keys.sort;

@boxes = (@boxes xx $duplicates).flat.sort if $duplicates > 1;

say @boxes.combinations if $verbose;

my %w;
my %v;

for @boxes.combinations.grep(0 < *.elems <= $boxcount) -> @list
{
  my $key    = @list.join;

  next if %w{$key}.defined;

  my $weight = @list.map({ %weight{$_} }).sum;
  my $value  = @list.map({ %value{$_}  }).sum;

  if $weight <= $maxweight
  {
    %w{$key} = $weight; 
    %v{$key} = $value;
    
    say "{ @list } -> $weight kg -> £ $value" if $verbose;
  }
  elsif $verbose
  {
    say "{ @list } -> $weight kg -> £ $value (> $maxweight kg; ignored)";
  }
}

my $max = %v.values.max;

say "Highest value: £ $max" if $verbose;

my @solutions = %w.keys.grep( { %v{$_} == $max } );

my $min = @solutions.map( { %w{$_} } ).min;

say "Lowest weight: $min kg" if $verbose;

for @solutions -> $solution
{
  say "{ $solution.comb.join(",") }: { %w{$solution} } kg at £ { %v{$solution} }." if %w{$solution} == $min;
}
