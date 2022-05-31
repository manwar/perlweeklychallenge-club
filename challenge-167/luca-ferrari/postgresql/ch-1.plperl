-- Perl Weekly Challenge 167
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc167;

CREATE OR REPLACE FUNCTION
pwc167.task1_plperl()
RETURNS SETOF int
AS $CODE$

# utility function to check if a number is prime
my $is_prime = sub {
   my ($num) = @_;
   for ( 2 .. $num - 1 ) {
     return 0 if ( $num % $_ == 0 );
   }

  return 1;
};

# get all the permutations
my $compute_permutations = sub {
  my ($num) = @_;
  my @perms;
  my @digits = split //, $num;

  for ( 0 .. $#digits  ) {
      push @perms, join( '',        @digits[ $_ .. $#digits ], @digits[ 0 .. $_ - 1 ] );
  }

  return @perms;
};

# check if the given number is a
# cyclic prime
my $is_cyclic_prime = sub {
  my ($value) = @_;

  return 0 unless( $is_prime->( $value ) );
  for ($compute_permutations->( $value ) ) {
      return 0 unless( $is_prime->( $_ ) );
  }

  return 1;
};

for ( 100 .. 999 ) {
    return_next( $_ ) if $is_cyclic_prime->( $_ );
}

return undef;

$CODE$
LANGUAGE plperl;
