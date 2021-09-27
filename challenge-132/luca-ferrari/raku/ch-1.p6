#!raku


multi sub MAIN( Str $date where { $date ~~ / \d ** 4 '/' \d ** 2 '/' \d ** 2 / } ) {
    $date ~~ / (\d ** 4 ) '/' (\d ** 2 ) '/' ( \d **2 ) /;
    MAIN( $0 ~ '-' ~ $1 ~ '-' ~ $2  );
}

multi sub MAIN( Str $date where { $date ~~ / \d ** 4 '-' \d ** 2 '-' \d ** 2 / } ) {
    my $birthday = Date.new: $date;
    my $today = Date.today;
    my $days = $today - $birthday;
    my @dates = $birthday - $days, $today + $days;
    @dates.join( ', ' ).say;
}
