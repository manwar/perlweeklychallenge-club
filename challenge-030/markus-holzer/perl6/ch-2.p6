.say for
    ( ( 2, 4 ... 10 ) X combinations( 1 .. 10, 2 ) )
    .map(  { .flat.cache  })
    .grep( { .sum == 12   })
    .map(  { .join(", ")  })
;

sub combinations( @combinatees, $places) { combinations( @combinatees, $places - 1 ) X @combinatees if $places > 0 }