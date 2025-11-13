#!raku

#
# Perl Weekly Challenge 347
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
#

sub MAIN( Str $date ) {
    my %months = 'Jan' => 1,
		 'Feb' => 2,
		 'Mar' => 3,
		 'Apr' => 4,
		 'May' => 5,
		 'Jun' => 6,
		 'Jul' => 7,
		 'Aug' => 8,
		 'Sep' => 9,
		 'Oct' => 10,
		 'Nov' => 11,
		 'Dec' => 12;

    if ( $date ~~ / ^ $<day> = ( \d{1 .. 2} ) ( 'st' | 'nd' | 'rd' | 'th' ) \s+ $<month> = ( \w+ ) \s+ $<year> = ( \d+ ) $  / ) {
	say '%04d-%02d-%02d'.sprintf: $/<year>, %months{ $/<month> }, $/<day>;
    }

}
