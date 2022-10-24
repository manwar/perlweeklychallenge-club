#!raku

# Perl Weekly Challenge 187

sub MAIN( Str $start-foo, Str $end-foo, Str $start-bar, Str $end-bar ) {

    $start-foo ~~ / ^ ( \d ** 2 ) '-' ( \d ** 2 ) $ /;
    my $foo-days-start = DateTime.new: year => 2022, day => $/[0], month => $/[1];
    $end-foo ~~ / ^ (\d ** 2) '-' (\d **2) $ /;
    my $foo-days-end = DateTime.new: year => 2022, day => $/[0], month => $/[1];

    $start-bar ~~ / ^ ( \d ** 2 ) '-' ( \d ** 2 ) $ /;
    my $bar-days-start = DateTime.new: year => 2022, day => $/[0], month => $/[1];
    $end-bar ~~ / ^ ( \d ** 2 ) '-' ( \d ** 2 ) $ /;
    my $bar-days-end = DateTime.new: year => 2022, day => $/[0], month => $/[1];

    my $days = 0;
    my $start = $foo-days-start >= $bar-days-start ?? $bar-days-start !! $foo-days-start;
    my $end   = $foo-days-end >= $bar-days-end ?? $foo-days-end !! $bar-days-end;
    
    while ( $start < $end ) {
    	  $days++ if ( $start >= $foo-days-start
	  && $start <= $foo-days-end
	  && $start >= $bar-days-start
	  && $start <= $bar-days-end );
	  $start .= later( days => 1 );
    }

    say $days;
}
