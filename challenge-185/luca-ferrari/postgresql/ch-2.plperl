-- Perl Weekly Challenge 185
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc185;

CREATE OR REPLACE FUNCTION
pwc185.task2_plperl( text )
RETURNS text
AS $CODE$
my ( $input ) = @_;
my @output;
my $counter = 4;

for ( split( //, $input ) ) {
    push @output, 'x' and $counter-- and next if ( /[a-z0-9]/i ) and $counter > 0;
    push @output, $_;
}

return join( '', @output );
$CODE$
LANGUAGE plperl;
