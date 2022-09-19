-- Perl Weekly Challenge 164
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc164;

CREATE OR REPLACE FUNCTION
pwc164.task1_plperl( int )
RETURNS SETOF int
AS $CODE$
  my ( $limit ) = @_;

  my $is_prime = sub {
     my ( $number ) = @_;
     for my $i ( 2 .. $number - 1 ) {
         return 0 if $number % $i == 0;
     }

     return 1;
  };

  my $is_palindrome = sub {
     return $_[ 0 ] eq reverse $_[ 0 ];
  };

  for  ( 10 .. $limit ) {
      return_next( $_ ) if $is_prime->( $_ ) && $is_palindrome->( $_ );
  }

  return undef;
$CODE$
LANGUAGE plperl;
