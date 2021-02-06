multi sub insert-pos(@N, $N ) {
  $_ + so @N[ $_ ] != $N given @N.grep( * <= $N, :k ).tail
}

multi sub insert-pos(@N, $N where $N > @N[*-1] ) { +@N }

multi sub insert-pos(@N, $N where $N < @N[0] ) { 0 }
