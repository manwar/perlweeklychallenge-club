sub f {
    my @matrix = @_;
    my $size = 0 + @{ $matrix[0] };
    my @knows_nobody = grep { my $i=$_; !grep $_, @{$matrix[$i]} } 0 .. $size-1;
    return -1 if @knows_nobody != 1; # must be just one candidate
    my $c = $knows_nobody[0];        # $c is the candidate index
    # if all others know the candidate, all others have 1 in the candidate column:
    $size - 1 == eval( join'+',map $$_[$c], @matrix ) ? $c : -1
}

my @tests = (
{
    input => [
        [0, 0, 0, 0, 1, 0],  # 0 knows 4
        [0, 0, 0, 0, 1, 0],  # 1 knows 4
        [0, 0, 0, 0, 1, 0],  # 2 knows 4
        [0, 0, 0, 0, 1, 0],  # 3 knows 4
        [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
        [0, 0, 0, 0, 1, 0],  # 5 knows 4
        ],
    output => 4
},
{
    input => [    
        [0, 1, 0, 0],  # 0 knows 1
        [0, 0, 1, 0],  # 1 knows 2
        [0, 0, 0, 1],  # 2 knows 3
        [1, 0, 0, 0]   # 3 knows 0
        ],
    output => -1
},
{
    input => [    
        [0, 0, 0, 0, 0],  # 0 knows NOBODY
        [1, 0, 0, 0, 0],  # 1 knows 0
        [1, 0, 0, 0, 0],  # 2 knows 0
        [1, 0, 0, 0, 0],  # 3 knows 0
        [1, 0, 0, 0, 0]   # 4 knows 0
        ],
    output => 0
},
{
    input => [    
        [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
        [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
        [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
        [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
        [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
        [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
        ],
    output => 3
},
{
    input => [    
        [0, 1, 1, 0],  # 0 knows 1 and 2
        [1, 0, 1, 0],  # 1 knows 0 and 2
        [0, 0, 0, 0],  # 2 knows NOBODY
        [0, 0, 0, 0]   # 3 knows NOBODY
        ],
    output => -1
},
{
    input => [    
        [0, 0, 1, 1],  # 0 knows 2 and 3
        [1, 0, 0, 0],  # 1 knows 0
        [1, 1, 0, 1],  # 2 knows 0, 1 and 3
        [1, 1, 0, 0]   # 3 knows 0 and 1
        ],
    output => -1
}
);

print f( @{ $$_{input} } ) == $$_{output} ? "ok\n" : "ERROR\n" for @tests;
