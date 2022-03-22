CREATE SCHEMA IF NOT EXISTS pwc156;

CREATE OR REPLACE FUNCTION
pwc156.weird( int )
RETURNS bool
AS $CODE$

use Algorithm::Knapsack;
my @divisors;

for my $i ( 2 .. $_[0] - 1 ) {
   push @divisors, $i if $_[0] % $i == 0;
}

my $sum = 0;
for my $i ( @divisors ) {
   $sum += $i;
}


return 0 if $sum <= $_[0];

my $knapsack = Algorithm::Knapsack->new(
    capacity => $_[0],
    weights  => \@divisors,
);
 
$knapsack->compute();
 
foreach my $solution ($knapsack->solutions()) {
    my @founds = @divisors[ $solution->@* ];
    my $sum = 0;
    $sum += $_ for ( @founds );
    return 0 if $sum == $_[0];
 
}


return 1;
$CODE$
LANGUAGE plperlu;




SELECT n
FROM generate_series( 1, 100 ) n
WHERE pwc156.weird( n );
