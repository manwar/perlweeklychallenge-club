#! /usr/bin/env raku

unit sub MAIN ($string where $string.chars > 2 && $string ~~ /^<[0..9]>*$/,
  :v(:$verbose));

my $bitmap-length = $string.chars -1;

for 0 .. Inf -> $i
{
  my $binary = $i.base(2);

  last if $binary.chars > $bitmap-length;

  my $bitmap  = $binary.fmt('%0' ~ $bitmap-length ~ 'd');
  my $bitmap2 = $bitmap;

  $bitmap ~~ tr/01/ |/;

  my @bitmap = $bitmap.comb;
  my $new    = (roundrobin($string.comb, @bitmap)).flat.join;
  $new ~~ s:g/\s//;

  my @array = $new.split("|");

  say ":: $string -> $bitmap2 -> '$bitmap' -> $new" if $verbose;

  next unless @array.elems >= 3;

  if is-additive(@array)
  {
    say 'true';
    exit;
  }
}

say 'false';

sub is-additive (@array)
{
  my $first  = @array.shift;
  my $second = @array.shift;

  while (@array.elems)
  {
    my $third = @array.shift;

    return False unless $first + $second == $third;

    $first = $second;
    $second = $third;
  }

  return True;
}
