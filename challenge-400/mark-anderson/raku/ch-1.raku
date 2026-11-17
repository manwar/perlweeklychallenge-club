#!/usr/bin/env raku
use Math::Combinatorics <variations>;
use JSON::Fast;
use Test;

sub largest-interval($int)
{
    return f($int).rotor(2 => -1)
                  .map({ .tail - .head })
                  .max;

    sub f($int)
    {
        gather for 1..$int.chars -> $k
        {
            for variations([0..9], $k)
            {
                my $n = .join;
                next if $n.starts-with(0); 
                last if $n > $int;
                take $n
            }
        }
    }
}

my %json = from-json "../../examples/json/ch-1.json".IO.slurp;

for %json<examples>.flat -> $example
{
    is largest-interval(~$example<in>), $example<out>, $example<name>
}
