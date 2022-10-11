-- Perl Weekly Challenge 186
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc186;

CREATE OR REPLACE FUNCTION
pwc186.task2_plperl( text )
RETURNS text
AS $CODE$

use Unicode::Normalize;

my ( $input ) = @_;
my @chars;

my $nfd = NFD $input;
for ( $nfd =~ / (\X) /xg ) {
    $_ =~ / (.) /x;
    push @chars, $1;
}

return join('', @chars );
$CODE$
LANGUAGE plperlu;
