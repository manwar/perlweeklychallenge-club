#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.f = 'in01.txt');

use MONKEY-SEE-NO-EVAL;

my ($source, $destination);
my @routes;
EVAL $f.IO.slurp;

my @vertexes = @routes[*;*].unique;
my %edges;

for @routes -> @route {
    for @route.rotor(2 => -1) -> ($v1, $v2) {
        %edges{$v1}.push($v2);
        %edges{$v2}.push($v1);
    }
}

my %dist = $source => 0;
my %Q is SetHash = @vertexes;
my %prev;
my $found = False;

# dijkstra
Outer:
while +%Q {
    my $min-dist = %Q.keys.map(-> $k { %dist{$k} with %dist{$k} }).min;
    last if $min-dist ~~ Inf;

    my $u = %dist.keys.grep(-> $k { %Q{$k}.defined and %dist{$k} == $min-dist }).first.Int;
    last unless %edges{$u} (&) %Q;

    %Q.unset($u);

    for %edges{$u}.Array -> $v {
        next unless %Q{$v};
        %prev{$v} = $u;
        %dist{$v} = %dist{$u} + 1;
        { $found = True; last Outer } if $v == $destination;
    }
}

if $found {
    my $v = $destination;
    my @path = $v;
    while $v != $source {
        $v = %prev{$v};
        @path.unshift($v);
    }

    put @path.join(', ');
} else {
    put -1;
}
