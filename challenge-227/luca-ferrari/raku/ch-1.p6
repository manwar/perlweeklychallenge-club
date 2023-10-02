#!raku

#
# Perl Weekly Challenge 227
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
#

sub MAIN( Int $year where { 1753 <= $year <= 9999 }, Bool :$verbose = True ) {
    my @fridays;
    for 1 .. 12 -> $month {
	my $day = Date.new( year => $year, day => 13, month => $month );
	@fridays.push: $day if ( $day.day-of-week == 5 );
    }

    @fridays.elems.say;
    @fridays.join( ', ' ).say if $verbose;
}
