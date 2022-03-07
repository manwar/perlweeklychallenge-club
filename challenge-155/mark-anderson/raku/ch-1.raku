#!/usr/bin/env raku

my @fortunates;

for 1..*
{
     my $f = fortunate($_);
     @fortunates.push: $f unless $f (elem) @fortunates;
     last if @fortunates == 8;
}

say sort @fortunates;

sub fortunate(\n)
{
    my \primorial = [*] (2..*).grep(&is-prime).head(n);
    (primorial+2..*).first(&is-prime) - primorial;
}
