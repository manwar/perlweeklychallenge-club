#! /usr/bin/env raku

unit sub MAIN (Str :k(:$key), Str :s(:$string), :d(:$decode), :v(:$verbose));

my %todo    = ('A' .. 'I', 'K' .. 'Z').Set;
my @key;
my $padding = 'X';
my $one     = $decode ?? -1 !! 1;

for $key.uc.comb -> $char
{
  next if $char eq " ";
  next unless %todo{$char};
  %todo{$char} :delete;
  @key.push: $char;
}

for sort keys %todo -> $todo
{
  @key.push: $todo;
}

if $verbose
{
  say ": Key: @key[ $_ * 5 ..  $_ * 5 + 4]" for ^5;
}

my %rev; for ^@key.elems -> $index { %rev{@key[$index]} = $index }

my @x = $string.uc.words>>.comb.flat.map: { $_ eq "J" ?? "I" !! $_ };

say ": String: { @x.join }" if $verbose;

my @pairs;

my $first = @x.shift;

while (@x)
{
  if @x[0] eq $first
  {
    @pairs.push: $first ~ $padding;
  }
  else
  {
    @pairs.push: $first ~ @x.shift;
  }
  $first = @x.elems ?? @x.shift !! Any;
}

@pairs.push: $first ~ $padding if $first;

say ": Pairs: { @pairs.join(" ") }" if $verbose;

my @result;

for @pairs -> $pair
{
  @result.push: wheatstone-playfair($pair);
}

say @result>>.lc.join;

sub wheatstone-playfair ($pair)
{
  my ($a, $b)         = $pair.comb;
  my ($a-row, $a-col) = (%rev{$a} div 5, %rev{$a} % 5);
  my ($b-row, $b-col) = (%rev{$b} div 5, %rev{$b} % 5);

  my $trans = "";
  my $rule  = "";

  if $a-row == $b-row
  {
    $trans = @key[$a-row * 5 + ( ($a-col + $one) % 5 ) ] ~
             @key[$b-row * 5 + ( ($b-col + $one) % 5 ) ];
    $rule = 'row';	     
  }
  elsif $a-col == $b-col
  {
    $trans = @key[( ($a-row + $one) % 5) * 5 + $a-col ] ~
             @key[( ($b-row + $one) % 5) * 5 + $b-col ];
    $rule = 'col';
  }
  else # $a-row != $b-row && $a-col != $b-col
  {
    $trans = @key[$a-row * 5 + $b-col] ~
             @key[$b-row * 5 + $a-col];
    $rule = 'rect';	     
  }

  say ": $pair -> $a-row $a-col + $b-row $b-col -> $trans [$rule]" if $verbose;
  
  return $trans;
}
