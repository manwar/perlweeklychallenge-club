#!raku


sub MAIN( Int $n where { $n > 0 } ) {
    $n.say and exit if $n == 1;

    my Int $current-solution = $n +> 1;  # divide by two
    my Int $next-solution    = 0;
    while ( $next-solution < $current-solution ) {
        $next-solution    = ( $current-solution + $n / $current-solution ) +> 1 if ! $next-solution;
        ( $current-solution, $next-solution ) = $next-solution,
                                                ( $next-solution + $n / $next-solution ) +> 1;
        
    }

    $current-solution.say;

}
