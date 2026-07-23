#!/usr/bin/perl
use 5.40.1;
use warnings;
use vars qw/ $dfs /;

sub isSquare($x) {
    my $r = int(sqrt($x));
    return $r * $r == $x;
}

sub buildGraph($n) {
    my %graph;
    for my $i (1 .. $n) {
        for my $j (1 .. $n) {
            if ($i == $j) {
                next;
            }
            if (isSquare($i + $j)) {
                push @{ $graph{$i} }, $j;
            }
        }
    }
    return \%graph;
}

sub search($n, $graph) {

    my @path = (1);
    my %used = (1 => 1);

    our $dfs = sub ($pos) {
        if ($pos == $n) {
            return isSquare($path[-1] + $path[0]);
        }

        my $current = $path[-1];
        for my $next (@{ $graph->{$current} || [] }) {
            if ($used{$next}) {
                next;
            }
            $used{$next} = 1;
            push @path, $next;

            if ($dfs->($pos + 1)) {
                return true;
            }

            pop @path;
            delete $used{$next};
        }
        return false;
    };

    return $dfs->(1) ? \@path : undef;
}

my ($n) = @ARGV;

my $circle = search($n,  buildGraph($n));

say $circle ? (join q{, }, @{$circle}) : '()';
