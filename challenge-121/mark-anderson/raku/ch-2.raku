#!/usr/bin/env raku

use Test;
plan 4;

is branch-and-bound([ ∞, 5, 2, 7 ],
                    [ 5, ∞, 5, 3 ],
                    [ 3, 1, ∞, 6 ],
                    [ 4, 5, 4, ∞ ]), 10,
                    'Example 1';
 
is branch-and-bound([ ∞,  15, 30, 4  ],
                    [ 6,  ∞,  4,  1  ],
                    [ 10, 15, ∞,  16 ],
                    [ 7,  18, 13, ∞  ]), 36,
                    'https://www.youtube.com/watch?v=cSY82XtVqYg&t=761s';

is branch-and-bound([ ∞,  20, 30, 10, 11 ],
                    [ 15, ∞,  16, 4,  2  ],
                    [ 3,  5,  ∞,  2,  4  ],
                    [ 19, 6,  18, ∞,  3  ],
                    [ 16, 4,  7,  16, ∞  ]), 28,
                    'https://www.youtube.com/watch?v=1FEP_sNb62k';

is branch-and-bound([ ∞,  14, 4,  10, 20 ],
                    [ 14, ∞,  7,  8,  7  ],
                    [ 4,  5,  ∞,  4,  16 ],
                    [ 11, 7,  9,  ∞,  2  ],
                    [ 18, 7,  17, 4,  ∞  ]), 30,
                    'https://www.youtube.com/watch?v=HjSbaKF8Gi0';

say branch-and-bound(random-matrix(15));
say branch-and-bound(random-matrix(20));

class Node
{
    has $.cost is rw;
    has @.path;
    has @.matrix;

    method Reduce
    {
        for ^2
        {
            for @.matrix -> @r 
            {
                my $min = @r.min;

                unless $min == 0|∞
                {
                    $.cost += $min;
                    @r.map(* -= $min);
                }
            }

            @.matrix  = ([Z] @.matrix)>>.Array;
        }
    }

    method paths
    {
        my @rest = ((1..@.matrix) ∖ @.path).keys;
        my @p = @.path xx @rest;
  
        @p.map({ $_ = [ |$_, @rest.pop ] }).Array; 
    }

    method set-Infs
    {
        my $r = @.path[*-2]-1;
        my $c = @.path[*-1]-1;

        @.matrix[$r].map({ $_ = ∞ });
        @.matrix.map({ .[$c] = ∞ });
        @.matrix[$c;@.path[0]-1] = ∞;
    }
}

multi branch-and-bound(+@matrix)
{
    my $node = Node.new(:path([1]), :matrix(@matrix)) andthen .Reduce;
    my Node @a = [ $node, Node.new(:cost(∞)) ];

    branch-and-bound(@a);
}

multi branch-and-bound(Node @nodes)
{
    my $n = @nodes.shift;

    return $n.cost if $n.path == $n.matrix; 

    for $n.paths -> @p
    {
        my $node = Node.new(:path(@p)); 
        $node.matrix = $n.matrix.duckmap(*.clone);
        $node.set-Infs;
        $node.Reduce;
        $node.cost += sum $n.cost, $n.matrix[@p[*-2]-1;@p[*-1]-1]; 
        my $i = @nodes.first(*.cost >= $node.cost, :k);
        @nodes.splice($i, 0, $node);
    }

    branch-and-bound(@nodes);
}

sub random-matrix($n)
{
    my @m = [ roll $n, (1..$n*2) ] xx $n;
    @m.map({ .[$++] = ∞ });
    @m;
}
