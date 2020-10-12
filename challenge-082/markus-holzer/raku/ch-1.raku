unit sub MAIN( Int $N, Int $M );

say "({ join ', ', grep all( $N, $M ) %% *, 1 ..^ max $N, $M })"