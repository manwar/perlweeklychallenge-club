#! /usr/bin/env raku

unit sub MAIN ($str is copy, :v(:$verbose));

my ($length, $has-len, $has-lc, $has-uc, $has-digit);

my $steps = 0;

loop
{
  $length    = $str.chars;
  $has-len   = $length >= 6;
  $has-lc    = so $str ~~ /<[a..z]>/;
  $has-uc    = so $str ~~ /<[A..Z]>/;
  $has-digit = so $str ~~ /<[0..9]>/;

  my $has-three = so $str ~~ /(.) {} :my $c=$0; <?after $c ** 3>/;

  if $verbose
  {
    say ": Length: $length";
    say ": Has OK Length : $has-len";
    say ": Has Lower Case: $has-lc";
    say ": Has Upper Case: $has-uc";
    say ": Has Digit : $has-digit";
    say ": Has 3 repeated chars : $has-three";
  }

  last unless $has-three;

  my @tokens = tokenizer($str);

  say ": Tokens: { @tokens.join(";") }" if $verbose;

  my $new = "";
  for @tokens -> $token
  {
    $token.chars >= 3
      ?? ( $new ~= $token.substr(0,2) ~ get-char-to-add($token, $new ~ $str) ~ $token.substr(3); $steps++; )
      !! ( $new ~= $token );
  }
  $str = $new;
  say ": Str: $str\n" if $verbose;
}

{ $steps++; $str ~= ('a'..'z').pick } unless $has-lc;
{ $steps++; $str ~= ('A'..'Z').pick } unless $has-uc;
{ $steps++; $str ~= ('0'..'9').pick } unless $has-digit;

say ": Str: $str (after adding missing types)" if $verbose;

while $str.chars < 6
{
  $str ~= get-char-to-add($str);
  $steps++;
}

say ": Str: $str (after fixing length)" if $verbose;

say $steps;

sub tokenizer ($str)
{
  return gather
  {
    my @chars = $str.comb;
    my $first = @chars.shift;
    my $count = 1;

    while @chars
    {
      my $second = @chars.shift;
      if $first ne $second
      {
        take $first x $count;
        $first = $second;
        $count = 1;
      }
      else
      {
        $count++;
      }
    }

    take $first x $count;
  }
}

multi sub get-char-to-add ($string)
{
  return ("a" .. "z", "0" .. "9").flat.pick if $string ~~ /<[A..Z]>$/;
  return ("a" .. "z", "A" .. "Z").flat.pick if $string ~~ /<[0..9]>$/;
  return ("A" .. "Z", "0" .. "9").flat.pick if $string ~~ /<[a..z]>$/;
}

multi sub get-char-to-add ($string, $has)
{
  if $string ~~ /<[A..Z]>$/
  {
    return ("a" .. "z").pick unless $has ~~ /<[a..z]>/;
    return ("0" .. "9").pick;
  }

  if $string ~~ /<[a..z]>$/
  {
    return ("A" .. "Z").pick unless $has ~~ /<[A..Z]>/;
    return ("0" .. "9").pick;
  }

  if $string ~~ /<[0..9]>$/
  {
    return ("A" .. "Z").pick unless $has ~~ /<[A..Z]>/;
    return ("a" .. "z").pick;
  }
}
