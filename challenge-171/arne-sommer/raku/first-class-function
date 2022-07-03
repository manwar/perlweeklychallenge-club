#! /usr/bin/env raku

my $f = sub f ($val)
{
  return $val * 10;
}

my $g = sub g ($val)
{
  return $val + 1;
}

sub compose(&f, &g)
{
  return sub ($arg)
  {
    &f(&g($arg));
  };
}

my $h = compose($f, $g);

say $h(12);
say $h(13);

my $m = compose($g, $f);

say $m(12);
say $m(13);


