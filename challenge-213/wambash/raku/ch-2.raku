#!/usr/bin/env raku

use v6.e.*;

sub make-graph (+@routes) {
    @routes
    andthen |$_,|.map: *.reverse
    andthen .map: |*.rotor: 2 => -1
    andthen .classify: *.[0], as => *.[1]
}

sub step-depth (+@route, :%graph) {
    %graph{@route.tail}
    andthen .grep: * ∉ @route
    andthen .map: { |@route, $_ }\
    andthen .Slip
}


sub shortest-route (+@routes,:$source!,:$destination!) {
    my %graph = make-graph @routes;
    (($source,),), { .map: &step-depth.assuming: :%graph } ... :!elems
    andthen .map: *.cache.grep: *.tail eqv $destination
    andthen .first: *.elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    my %graph :=  make-graph( (1,2,3,5), (2, 4) );
    is %graph.gist, :{1 => [2], 2 => [3,4,1], 3 => [5,2], 4 => [2], 5 => [3]}.gist;
    is step-depth( 1,2,3, :%graph), (1,2,3,5);
    is step-depth( 1, :%graph), (1,2);
    is step-depth( 2,1, :%graph).elems, 0;
    is-deeply step-depth( 1,2, :%graph), slip((1,2,3),(1,2,4));
    is shortest-route((1,2,6),(5,6,7),:1source,:7destination),(1,2,6,7);
    is shortest-route((1,2,3),(4,5,6,7),:1source,:7destination),Nil;
    is shortest-route([1,2,3], [4,5,6], [3,8,9], [7,8], :1source,:7destination), (1,2,3,8,7);
    done-testing;
}

multi MAIN (*@routes,Str :s(:$source)!,Str :d(:$destination)!) {
    say shortest-route |@routes.map( *.split(',').cache ), :source($source.Str), :destination($destination.Str)
}
