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
        my @cost;
    
        for ^2
        {
            for @.matrix -> @r 
            {
                my $min = @r.min;
                $min = 0 if $min == ∞;
                @cost.push($min);

                for @r -> $n is rw
                {
                    $n -= $min;
                    $n = ∞ if $n ~~ NaN;
                }
            }

            @.matrix  = [Z] @.matrix;
            @.matrix .= map(*.Array);
        }
    
        $.cost = @cost.sum;
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
    branch-and-bound($node, []);
}

multi branch-and-bound($n, @leaves)
{
    return $n.cost if $n.path == $n.matrix; 

    my $node;
    my @nodes = Empty;

    for $n.paths -> @p
    {
        $node = Node.new(:path(@p)); 
        $node.matrix = $n.matrix.duckmap(*.clone);
        $node.set-Infs;
        $node.Reduce;
        $node.cost += sum $n.cost, $n.matrix[@p[*-2]-1;@p[*-1]-1]; 
        @nodes.push($node);
    }

    my $min = @nodes.map(*.cost).min;
    my $k = @leaves.first(*.cost < $min, :k); 

    if $k.defined
    {
        $node = @leaves.splice($k, 1).head;
    }

    else
    {
        $k = @nodes.first(*.cost == $min, :k);
        $node = @nodes.splice($k, 1).head;
    }

    @leaves.append(@nodes); 
    branch-and-bound($node, @leaves);
}

sub random-matrix($n)
{
    my @m = ([ roll $n, (1..$n*2) ] xx $n);
    @m.map({ .[$++] = ∞ });
    @m;
}
