#! /usr/bin/env raku

sub digit-value ($char)
{
  given $char
  {
    when '0' .. '9' { $char.Int }
    when 'A' .. 'Z' { $char.ord - 'A'.ord + 10 }
    when 'a' .. 'z' { $char.ord - 'a'.ord + 36 }
    when '+'        { 62 }
    when '/'        { 63 }
  }
}

multi sub MAIN (Str :n(:$num), Int :b(:$base) where 1 == $base, :v(:$verbose))
{
  say $num.chars;
}

multi sub MAIN (Str :n(:$num), Int :b(:$base) where 2 <= $base <= 64, :v(:$verbose))
{
  my $alphabet = ('0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/')>>.join.join.substr(0, $base);
  my %alphabet = $alphabet.comb.Set;

  my $result   = 0;

  say ": Alphabet: $alphabet" if $verbose;

  for $num.comb -> $char
  {
    die "Illegal char $char in a base $base number" unless %alphabet{$char};
    my $new = $result * $base;
    my $add = digit-value($char);
    $result = $new + $add;

    say ": adding $add ($char) to $new -> $result" if $verbose;
  }

  say $result;
}
