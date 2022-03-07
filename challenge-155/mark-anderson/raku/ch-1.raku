#!/usr/bin/env raku

say sort unique (1..*).map(&fortunate).head(8);

sub fortunate(\n)
{
    my \primorial = [*] (2..*).grep(&is-prime).head(n);
    (primorial+2..*).first(&is-prime) - primorial;
}
