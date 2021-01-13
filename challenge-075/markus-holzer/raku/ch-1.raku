sub c( $S, @C, *@c ) {
	if ( my $s = @c.sum ) <= $S {
		take [@c.sort] if $s == $S;
		c( $S, @C, @c, $_ ) for @C }}

say ( gather c 6, [1, 2, 4] ).unique: with => &[~~]