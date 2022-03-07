#!/usr/bin/env raku

while my @fortunates < 8
{
     my \f = fortunate(++$);
     @fortunates.push: f unless f (elem) @fortunates;
}

say sort @fortunates;

sub fortunate(\n)
{
    my \primorial = [*] (2..*).grep(&is-prime).head(n);
    (primorial+2..*).first(&is-prime) - primorial;
}
