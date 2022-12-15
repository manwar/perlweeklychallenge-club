-- Perl Weekly Challenge 195
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc195;

CREATE OR REPLACE FUNCTION
pwc195.task1_plperl( int, bool default true )
RETURNS int
AS $CODE$
  my ( $n, $verbose ) = @_;
  my @special_integers;

  my $baggify = sub {
     my ( $n ) = @_;
     my $bag = {};
     for my $digit ( split '', $n ) {
     	 $bag->{ $digit }++;
     }

     return $bag;
  };

  my $has_no_repetitions = sub {
     my ( $bag ) = @_;
     for ( keys $bag->%* ) {
     	 return 0 if $bag->{ $_ } != 1;
     }

     return 1;
  };

  for ( 1 .. $n ) {
     push @special_integers, $_ if ( $has_no_repetitions->( $baggify->( $_ ) ) );
  }

  elog( INFO, "Found: " . join( ',', @special_integers ) ) if ( $ verbose );
  return scalar @special_integers;

$CODE$
LANGUAGE plperl;
