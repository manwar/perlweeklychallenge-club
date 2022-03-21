CREATE SCHEMA IF NOT EXISTS pwc158;

CREATE OR REPLACE FUNCTION
pwc158.am( int[] )
RETURNS numeric
AS $CODE$
my $counter = 0;
my $sum     = 0;

for my $elem ( @{ $_[0] } ) {
    $counter++;
    $sum += $elem;
}

return $sum / $counter;
$CODE$
LANGUAGE plperl;



CREATE OR REPLACE FUNCTION
pwc158.gm( int[] )
RETURNS numeric
AS $CODE$
my $counter = 0;
my $mul     = 1;

for my $elem ( @{ $_[0] } ) {
    $counter++;
    $mul *= $elem;
}

return $mul ** ( 1 / $counter );
$CODE$
LANGUAGE plperl;


CREATE OR REPLACE FUNCTION
pwc158.hm( int[] )
RETURNS numeric
AS $CODE$
my $counter = 0;
my $sum     = 0;

my @n = map { 1 / $_ } @{ $_[0] };

for my $elem ( @n ) {
    $counter++;
    $sum += $elem;
}

return $counter / $sum;
$CODE$
LANGUAGE plperl;
