#!raku

sub MAIN( Int $year where { $year ~~ / \d ** 4 / } && $year > 1900,
        Bool :$verbose = False ) {
    my Date $date .= new: year => $year, day => 1, month => 1;
    my Date $stop .= new: year => $year, day => 31, month => 12;
    my $work-days = 0;
    while ( $date <= $stop ) {
        $work-days += 1 if $date.day-of-week != any( 6, 7 );
        $date = $date + 1;
    }

    "$year has $work-days work days".say if $verbose;
    $work-days.say if ! $verbose;
}
