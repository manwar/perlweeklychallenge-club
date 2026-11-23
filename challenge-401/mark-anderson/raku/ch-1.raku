#!/usr/bin/env raku
use JSON::Fast;
use Test;

sub fas($expr)
{
    .nude.join('/') given EVAL $expr
}

my %json = from-json "../../examples/json/ch-1.json".IO.slurp;

for %json<examples>.flat -> $example
{
    is fas($example<in>), $example<out>, $example<name>
}
