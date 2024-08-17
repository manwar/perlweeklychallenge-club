#!raku

#
# Perl Weekly Challenge 274
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-274>
#

sub MAIN() {

    my @routes = [ [12, 11, 41], [15, 5, 35] ];

    my @times;
    my $route = 0;

    my %timetable;

    my $preferred = False;
    for @routes -> $current_route {

	my ( $interval, $start_at, $time ) = $current_route;

	my $arrive_at = $start_at + $time;
	my $previous_bus_start_at = 0;

	while ( $arrive_at < 120 ) {
	    for 0 .. 59 -> $minute {
		last if $minute > $start_at;
		next if $minute < $previous_bus_start_at;
		%timetable{ $minute }.push: { start => $start_at, arrive => $arrive_at, route => $current_route.Str, preferred => $preferred };
	    }

	    $previous_bus_start_at = $start_at;
	    $start_at += $interval;
	    $arrive_at = $start_at + $time;
	}

	$preferred = True;
    }

    my @skip;
    for %timetable.keys.sort( * <=> * ) -> $minute {
	my @bus = %timetable{ $minute }.Array;
	next if ( @bus.elems == 1 && ! @bus[ 0 ]<preferred> );

	@skip.push: $minute if ( @bus.sort( { $^a<arrive> <=> $^b<arrive> } )[ 0 ]<preferred> );
    }


    @skip.say;



}
