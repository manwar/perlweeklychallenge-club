#! /usr/bin/env raku

subset DCB of Int where $_ ~~ /^1<[01]>*$/;

unit sub MAIN (DCB $a, DCB $b, :v(:$verbose));

my $length = max($a.chars, $b.chars);

say ": Max lenght: $length" if $verbose;

my @a = $a.comb.reverse;
my @b = $b.comb.reverse;

my $carry = 0;

my @result;

for ^$length -> $index
{
  my $aa  = @a.shift // 0;
  my $bb  = @b.shift // 0;
  my $sum = $carry + $aa + $bb;

  say ": a:$aa b:$bb c:$carry -> $sum" if $verbose;

  if    $sum == 3 { $sum = 1; $carry = 1; }
  elsif $sum == 2 { $sum = 0; $carry = 1; }
  elsif $sum == 1 {           $carry = 0; }
  elsif $sum == 0 {           $carry = 0; }

  @result.push: $sum; 
}

@result.push: $carry if $carry;

say @result.join.flip;
