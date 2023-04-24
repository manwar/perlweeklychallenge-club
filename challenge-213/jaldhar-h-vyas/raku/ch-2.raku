#!/usr/bin/raku

sub findKeyFor(@routes, $target) {
    for 0 .. @routes.end -> $i {
        for 0 .. @routes[$i].end -> $j {
            if @routes[$i;$j] == $target {
                return "$i-$j";
            }
        }
    }
    return "";
}

sub makeGraph(@routes) {
    my %graph;

    for 0 ..^ @routes.elems -> $i {
        for 0 ..^ @routes[$i].elems -> $j {
            if $j != 0 {
                %graph{"$i-$j"}.push("$i-" ~ $j - 1);
            }
            if $j != @routes[$i].end {
                %graph{"$i-$j"}.push("$i-" ~ $j + 1);
            } else {
                my $l = makeLink(@routes, $i, @routes[$i][@routes[$i].end]);
                unless $l eq q{} {
                    %graph{"$i-" ~ @routes[$i].end}.push($l);
                    %graph{$l}.push("$i-" ~ @routes[$i].end);
                }
            }
        }
    }
    return %graph;
}

sub makeLink(@routes, $currentRoute, $value) {
    for 0 .. @routes.end -> $i {
        if $i == $currentRoute {
            next;
        }
        for 0 ..^ @routes[$i].elems -> $j {
            if @routes[$i;$j] == $value {
                return "$i-$j";
            }
        }
    }
    return "";
}

sub traverse(%graph, $startNode) {
    my %visited;
    my @queue = ( $startNode );
    %visited{$startNode} = True;

    while @queue.elems {
        my @path = @queue.shift.flat;
        my $node = @path[*-1];
        take $node, @path;

        for %graph{$node}.values -> $v {
            if !%visited{$v} {
                %visited{$v} = True;
                @queue.push((my @next = @path).push($v));
            }
        }
    }

    take Nil, ();
}

sub findShortestPath(@routes, $source, $destination) {
    my %graph = makeGraph(@routes);
    my $startNode = findKeyFor(@routes, $source);
    my $endNode = findKeyFor(@routes, $destination);

    if $startNode eq q{} || $endNode eq q{} {
        return ();
    }

    for gather traverse(%graph, $startNode) -> ($node, @path) {
        if $node ~~ Nil {
            return ();
        }

        if $node ~~ $endNode {
            return @path;
        }
    }
}

sub MAIN(
    $source, $destination, *@list
) {
    my @routes = @list.map({ $_.split(/\s+/) });

    my @path = findShortestPath(@routes, $source, $destination);
    unless @path.elems {
        say -1;
        exit;
    }

    my ($route, $elem) = @path.shift.split(q{-});
    my $currentRoute = $route;
    my @results = ( @routes[$route;$elem] );

    for @path -> $node {
        my ($route, $elem) = $node.split(q{-});
        if $route == $currentRoute {
            @results.push(@routes[$route;$elem]);
        } else {
            $currentRoute = $route;
        }
    }

    say q{(}, @results.join(q{,}), q{)};
}