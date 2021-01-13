package Tree;
use warnings;
use strict;

use Exporter qw{ import };
our @EXPORT_OK = qw{ from_structure from_edges
                     to_structure to_edges to_graph
                     invert };

sub from_structure {
    my ($structure) = @_;
    my %tree;
    while ($structure =~ s/([0-9]+) \( ([0-9]+) , ([0-9]+) \) /$1/x) {
        my ($parent, $left, $right) = ($1, $2, $3);
        $tree{$parent} = [$left, $right];
    }
    my ($root) = $structure;
    return $root, \%tree
}

sub from_edges {
    my (@edges) = @_;
    my (%tree, @children);
    for my $edge (@edges) {
        my ($child, $direction, $parent) = $edge =~ /([0-9]+) ([LR]) ([0-9]+)/
            or die "Invalid format: '$edge'.\n";
        $tree{$parent}[ 'R' eq $direction ] = $child;
        push @children, $child;
    }
    my %root;
    @root{ keys %tree } = ();
    delete @root{ @children };
    my @roots = keys %root;
    die "One root not found: @roots." if @roots != 1;
    return $roots[0], \%tree
}

sub invert {
    my ($tree) = @_;
    for my $parent (keys %$tree) {
        $tree->{$parent} = [ reverse @{ $tree->{$parent} } ];
    }
}

sub to_structure {
    my ($node, $tree) = @_;
    return $node unless exists $tree->{$node};

    my @children = @{ $tree->{$node} };
    my $output = $node . '('
               . join(',', map to_structure($_, $tree), @children) . ')';
    return $output
}

sub to_edges {
    my ($tree) = @_;
    return [ map {
                 my $parent = $_;
                 map [ $tree->{$parent}[$_], qw( L R )[$_], $parent ], 0, 1
             } keys %$tree ]
}

sub to_graph {
    my ($root, $tree) = @_;
    _to_graph($root, $tree, my $output = []);
    return @$output
}

sub _to_graph {
    my ($root, $tree, $output, @lines) = @_;
    push @$output, $root;

    if (my @children = @{ $tree->{$root} // [] }) {
        push @$output, '-+-';
        _to_graph($children[0], $tree, $output, @lines,
                  (' ' x length($root)) . ' | ');
        push @$output, @lines, ' ' x length $root, ' \\-';
        _to_graph($children[1], $tree, $output, @lines,
                  (' ' x (2 + length($root))) . ' ');

    } else {
        push @$output, "\n";
    }
}

__PACKAGE__
