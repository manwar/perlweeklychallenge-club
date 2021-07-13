#!/usr/bin/env raku

my @matrix = [ ∞, 5, 2, 7 ],
             [ 5, ∞, 5, 3 ],
             [ 3, 1, ∞, 6 ],
             [ 4, 5, 4, ∞ ];

my ($cost, @reduced) = get-cost-and-reduced(@matrix);

say branch-and-bound([1], @reduced);

sub branch-and-bound(@path, @matrix)
{
    return $cost if @path.elems == @matrix.elems;

    my %h = Empty;
  
    for get-paths(@path) -> @p
    {
        my @m = prepare(@p, @matrix.duckmap(*.clone));
       (my $c, @m) = get-cost-and-reduced(@m); 
        my $total = [+] $cost, @matrix[@p[*-2]-1;@p[*-1]-1] + $c;

        %h{$total}<path>   = @p;
        %h{$total}<matrix> = @m;
    }

    $cost = .key with min %h;
    branch-and-bound(.value<path>, .value<matrix>) with min %h;
}
    
sub get-cost-and-reduced(@matrix)
{
    my @cost;
    my @m = @matrix.duckmap(*.clone);

    for ^2
    {
        for @m -> @r 
        {
            my $min = @r.min;
            $min = 0 if $min == ∞;
            @cost.push: $min;

            for @r -> $n is rw
            {
                $n -= $min;
                $n = ∞ if $n ~~ NaN;
            }
        }

        @m  = [Z] @m;
        @m .= map(*.Array);
    }

    @cost.sum, |@m;
}

sub get-paths(@a)
{
    my @nodes = 1..@matrix.elems;
    my @copy  = (@nodes (-) @a).keys;
    my @p = @a xx @copy;
  
    @p.map({ $_ = [ |$_, @copy.pop ] }).Array; 
}

sub prepare(@path, @matrix)
{
    my @m = @matrix.duckmap(*.clone);
    my $r = @path[*-2]-1;
    my $c = @path[*-1]-1;

    @m[$r].map({ $_ = ∞ });
    @m.map({ .[$c] = ∞ });
    @m[$c;@path[0]-1] = ∞;
    @m;
}
