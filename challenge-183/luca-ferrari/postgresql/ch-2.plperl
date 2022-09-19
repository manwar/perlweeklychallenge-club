-- Perl Weekly Challenge 183
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc183;

CREATE OR REPLACE FUNCTION
pwc183.task2_plperl( text, text )
RETURNS int[]
AS $CODE$

use DateTime;
my @dates;

for my $current_date ( @_ ) {
    $current_date =~ /^(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})$/;
    push @dates, DateTime->new( year  => $+{ year },
                                month => $+{ month },
                                day   => $+{ day } );
}

my $difference = $dates[ 0 ]->subtract_datetime( $dates[ 1 ] );
return [ $difference->in_units( qw/ years days / ) ];

$CODE$
LANGUAGE plperlu;
