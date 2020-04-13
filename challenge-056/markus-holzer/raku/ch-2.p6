my %tree =
    5 => {
        4 => {
            11 => {
                7 => Any,
                2 => Any
            },
        },
        8 => {
             9 => {
                1 => Any
             },
             7 => {
                2 => Any
             },
             13 => Any,
        }
    };

.join('→').say
    for find-path-sum( %tree, 22 );

multi sub find-path-sum( %tree, $n )
{
    gather find-path-sum( %tree, $n, [] );
}

multi sub find-path-sum( $tree, $n, $path )
{
    for $tree.keys -> $k
    {
        my $p = $path.clone.push( $k );

        if my $t = $tree{ $k }
        {
            find-path-sum( $t, $n, $p );
            next;
        }

        take $p if $p.sum == $n;
    }
}