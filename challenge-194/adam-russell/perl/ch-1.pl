use v5.34;
##
# You are given a time in the format hh:mm with one missing digit.
# Write a script to find the highest digit 0-9 that a valid time.
##
use Time::Piece;
sub digital_clock{
    my($s) = @_;
    map{
        my $d = $_;
	my $t = $s;
	$t =~ s/\?/$d/;
	eval{
            Time::Piece->strptime($t, q/%H:%M/); 
        }; 
	return $d unless $@;
    } 9, 8, 7, 6, 5, 4, 3, 2, 1, 0;
}

MAIN:{
    say digital_clock(q/?5:00/);
    say digital_clock(q/?3:00/);
    say digital_clock(q/1?:00/);
    say digital_clock(q/2?:00/);
    say digital_clock(q/12:?5/);
    say digital_clock(q/12:5?/);
}
