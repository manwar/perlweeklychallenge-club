#!/usr/bin/env raku
use JSON::Fast;
use Test;

class BFS
{
    has $.start;
    has $.end;
    has %.graph is Map;
    has @.queue;
    has %.path;
    has $.edge;

    submethod TWEAK
    {
        %!path := { $!start => Empty.Str }
        @!queue.push: ($!start, $_) for |%!graph{$!start}
    }
    
    method traverse
    {
        while none(@!queue ~~ Empty, ? all %!path{%!graph.keys})
        {
            while @!queue
            {
                $!edge = @!queue.shift; 
                last unless %!path{$!edge.tail}
            }
            
            %!path{$!edge.tail} = $!edge.head;
        
            for |%!graph{$!edge.tail} -> $node
            {
                @!queue.push: ($!edge.tail, $node) unless %!path{$node}
            }
        }
    }

    method result
    {
        my @result = [$!end];

        while %!path{@result.head} -> $node 
        {
            @result.unshift: $node;
            last if @result.head eq $!start;
        }

        if @result.head ne $!start
        {
            @result = Empty
        }

        else
        {
            if @result.head eq @result.tail
            {
                @result = @result.head 
            }
        }

        @result
    }
}

sub min-genetic-mutation($start, $end, @bank)
{
    my %graph;
    create-graph();

    my $bfs = BFS.new(:$start, :$end, :%graph);

    $bfs.traverse;
    return $bfs.result - 1;

    sub create-graph
    {    
        @bank.push: $start;

        for @bank X @bank -> ($a,$b)
        {
            %graph{$a}.push: $b 
            if .so ~~ one($a.comb >>ne<< $b.comb)
        }

        @bank.pop
    }
}

my %json = from-json "../../examples/json/ch-2.json".IO.slurp;

for %json<examples>.flat -> $example
{
    is min-genetic-mutation(|$example<in>), $example<out>, $example<name>
}
