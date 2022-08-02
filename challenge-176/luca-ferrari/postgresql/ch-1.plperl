-- Perl Weekly Challenge 176
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc176;

CREATE OR REPLACE FUNCTION
pwc176.task1_plperl()
RETURNS BIGINT
AS $CODE$

for my $current ( 1 .. 999999 ) {

    my @values = map { $_ * $current } ( 2 .. 6 );

    my $found = 1;
    for ( @values ) {
        my $sorted_digits = join( '', sort( split( '', $current ) ) );
        my $other_digits  = join( '', sort( split( '', $_ ) ) );

        $found = 0 if ( $sorted_digits != $other_digits );
        last if ! $found;
    }

    next if ! $found;
    return $current;
}

$CODE$
LANGUAGE plperl;
