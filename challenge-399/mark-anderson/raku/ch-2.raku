#!/usr/bin/env raku
use JSON::Fast;
use Test;

my %json = from-json("../../examples/json/ch-2.json".IO.slurp);

for %json<examples>.flat -> $example
{
    is lap($example<in>), $example<out>, $example<name>
}

sub lap($str)
{
    my @root;
    my $level = 0;

    max(.max,0) given gather 
    {
        for $str.split("\n") -> $line is copy 
        {
            my $tabs = quietly $line.match(/^\t+/).chars || 0;
            $line   .= subst(/^\t+/);

            paths($tabs) if $tabs < $level;
            $level = $tabs;
            @root[$level].push: $line
        }

        paths(0);

        sub paths($tabs)
        {
            while @root > $tabs
            {
                while @root.tail
                {
                    take @root>>.tail.join('/').chars if @root.tail
                                                              .tail
                                                              .contains('.');
                    @root.tail.pop
                }
          
                @root.pop
            }
        }
    }
}
