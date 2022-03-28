#!/usr/bin/env raku

say first-series(1000);

sub first-series(\n)
{
    .grep(&is-prime) given { (++$)³ - ($++)³ } ... * > n;
}
