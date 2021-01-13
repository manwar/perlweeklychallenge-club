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

multi sub find-path-sum( Hash:D $tree, Int $n )
{
    multi sub find-path-sum( Hash:D $tree, Int $n, Array $path ) {
        find-path-sum( $tree{ $_ }, $n - $_, $path.clone.push($_) )
            for $tree.keys; }

    multi sub find-path-sum( Any, Int $n, Array $path ) {
        take $path if $n == 0; }

    gather find-path-sum( $tree, $n, [] );
}