#!/usr/bin/env raku
use Test;

is-deeply shortest-route(((1,2,6), (5,6,7)),                              1,7),  (1,2,6,7);
is-deeply shortest-route(((1,2,3), (4,5,6)),                              2,5),  -1;
is-deeply shortest-route(((1,2,3), (4,5,6),  (3,8,9),   (7,8)),           1,7),  (1,2,3,8,7);

# Tests from James Smith's solution
is-deeply shortest-route(((1..7),  (2,8),    (8,6)),                      1,7),  (1,2,8,6,7);
is-deeply shortest-route(((1..15), (2,16),   (16,18,8), (9,17), (17,14)), 1,15), (1,2,16,18,8,9,17,14,15);

sub shortest-route($routes, $source, $destination is copy)
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
        LAST {take $source}
    }
}

sub graph($routes)
{
    my %graph;

    for |$routes -> $r 
    {
        $r.rotor(2 => -1).map(
        {
            %graph{.[0]}.push: .[1]; 
            %graph{.[1]}.push: .[0]
        })
    }
    
    %graph.values.map({ $_ = |.unique });
    %graph
}
