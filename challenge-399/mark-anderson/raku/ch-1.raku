#!/usr/bin/env raku
use JSON::Fast;
use Test;

my %json = from-json("../../examples/json/ch-1.json".IO.slurp);

for %json<examples>.flat -> $example
{
    my ($str, $k) = $example<in>;
    is lrc($str, $k), $example<out>, $example<name>
}

sub lrc($str, $k)
{
    my $rx = "<upper>" x $k+1 ~ " ** 1..*";
    $str ~~ m:ex/ <$rx> <?{ $/.comb.Bag.max(:v).head + $k >= $/.chars }> /
    andthen .max(*.chars).chars  
} 
