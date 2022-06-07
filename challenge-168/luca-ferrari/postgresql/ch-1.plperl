-- Perl Weekly Challenge 168
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc168;

CREATE OR REPLACE FUNCTION
pwc168.task1_plperl( int )
RETURNS SETOF bigint
AS $CODE$
  my ( $limit ) = @_;
  $limit //= 13;
  my @perrin = (3, 0, 2);
  my $seen = {};

  my $is_prime = sub {
   my ( $number ) = @_;

   for ( 2 .. $number - 1 ) {
       return undef if $number % $_ == 0;
   }

   return 1;
 };

  while ( $limit > 0 ) {
        my $current = $perrin[ -2 ] + $perrin[ -3 ];
        elog( DEBUG, "Limit $n and current is $current" );
        push @perrin, $current;
        next if ! $is_prime->( $current );
        next if $seen->{ $current };

        # found!
        $seen->{ $current }++;
        return_next( $current );
        $limit--;
  }

return undef;
$CODE$
LANGUAGE plperl;
