#!/usr/bin/env raku
use Test;

is-deeply shortest-path(((1,2,6), (5,6,7)), 1,7),                 (1,2,6,7);
is-deeply shortest-path(((1,2,3), (4,5,6)), 2,5),                 -1;
is-deeply shortest-path(((1,2,3), (4,5,6), (3,8,9), (7,8)), 1,7), (1,2,3,8,7);

# The graph from https://www.youtube.com/watch?v=T_m27bhVQQQ&t=360s
is-deeply shortest-path((<A C F>, <A G J>, <A B D>, 
                         <B A C>, <B D H>, 
                         <C A G>, <C F J>, <C G J>,
                         <D B A>, <D G J>, <D H J>,
                         <F C G>, <F J H>, 
                         <G A B>, <G C A>, <G D H>, <G J F>,
                         <H D G>, <H J G>,
                         <J F C>, <J G A>, <J H D>), 'A','H'), any(<A G J H>,
                                                                   <A B D H>,
                                                                   <A G D H>);

sub shortest-path($routes, $source, $destination is copy)
{
    my %graph = graph($routes);
    my $from = $source;
    my @queue;
    my %path;

    until %path{$destination}
    {
        @queue.push: $from => $_ unless %path{$_} for %graph{$from};
        return -1 unless @queue;
        %path{.value} = .key unless %path{.value} given @queue.head;
        $from = @queue.shift.value
    }

    reverse gather until $destination ~~ $source
    {
        take $destination;
        $destination = %path{$destination};
        LAST { take $source }
    }
}

sub graph($routes)
{
    my %graph;

    for |$routes -> $r
    {
        %graph{$r[0]}.push: $r[1];

        for 1..$r.end.pred
        {
            %graph{$r[$_]}.push: $r[.pred];
            %graph{$r[$_]}.push: $r[.succ]
        }

        %graph{$r[$r.end]}.push: $r[$r.end.pred]
    }

    %graph>>.values>>.unique>>.Slip
}
