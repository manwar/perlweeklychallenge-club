#!/usr/bin/perl
use 5.030;
use warnings;

sub findKeyFor {
    my ($routes, $target) = @_;

    for my $i (0 .. scalar @{$routes} - 1) {
        for my $j (0 .. scalar @{$routes->[$i]} - 1) {
            if ($routes->[$i]->[$j] == $target) {
                return "$i-$j";
            }
        }
    }
    return "";
}

sub makeGraph {
    my ($routes) = @_;
    my %graph;

    for my $i (0 .. scalar @{$routes} - 1) {
        for my $j (0 .. scalar @{$routes->[$i]} - 1) {
            if ($j != 0) {
                push @{$graph{"$i-$j"}}, "$i-" . ($j - 1);
            }
            my $end = scalar @{$routes->[$i]} - 1;
            if ($j != $end) {
                push @{$graph{"$i-$j"}}, "$i-" . ($j + 1);
            } else {
                my $l = makeLink($routes, $i, @{$routes->[$i]}[$end]);
                unless ($l eq q{}) {
                    push @{$graph{"$i-$end"}}, $l;
                    push @{$graph{$l}}, "$i-$end";
                }
            }
        }
    }

    return \%graph;
}

sub makeLink {
    my ($routes, $currentRoute, $value) = @_;
    for my $i (0 .. scalar @{$routes} - 1) {
        if ($i == $currentRoute) {
            next;
        }
        for my $j (0 .. scalar @{$routes->[$i]} - 1) {
            if ($routes->[$i][$j] == $value) {
                return "$i-$j";
            }
        }
    }
    return "";
}

sub traverse {
    my ($graph, $startNode, $endNode) = @_;
    my %visited;
    my @queue = ( [$startNode] );

    while (scalar @queue) {
        my $path = shift @queue;
        my $node = @{$path}[-1];
        if ($node eq $endNode) {
            return @{$path};
        }

        for my $v (@{$graph->{$node}}) {
            if (!exists $visited{$v}) {
                $visited{$v} = undef;
                my @next = @{$path};
                push @next, $v;
                push @queue, \@next;
            }
        }
    }
}


sub findShortestPath {
    my ($routes, $source, $destination) = @_;
    my $graph = makeGraph($routes);
    my $startNode = findKeyFor($routes, $source);
    my $endNode = findKeyFor($routes, $destination);

    if ($startNode eq q{} || $endNode eq q{}) {
        return ();
    }

    return traverse($graph, $startNode, $endNode);
}

my $source = shift;
my $destination = shift;
my @routes;
for my $route (@ARGV) {
    push @routes, [ split /\s+/, $route ];
}

my @path = findShortestPath(\@routes, $source, $destination);
unless (scalar @path) {
    say -1;
    exit;
}

my ($route, $elem) = split q{-}, shift @path;
my $currentRoute = $route;
my @results = ( $routes[$route][$elem] );

for my $node (@path) {
    my ($route, $elem) = split q{-}, $node;
    if ($route == $currentRoute) {
        push @results, $routes[$route][$elem];
    } else {
        $currentRoute = $route;
    }
}

say q{(}, (join q{,}, @results), q{)};
