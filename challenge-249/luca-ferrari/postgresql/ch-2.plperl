--
-- Perl Weekly Challenge 249
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
--

CREATE SCHEMA IF NOT EXISTS pwc249;

CREATE OR REPLACE FUNCTION
pwc249.task2_plperl( text )
RETURNS int[]
AS $CODE$
   my ( $string ) = @_;

  use Algorithm::Combinatorics qw(permutations);

  my @chars = split //, $string;
  my @nums = 0 .. $#chars;
  
  my $iter = permutations( \ @nums );
  while (my $perm = $iter->next) {
  	my $ok = 1;
  	for my $i ( 0 .. scalar( $perm->@* ) - 1 ) {
	    $ok = 0 if ( $chars[ $i ] eq 'D' && $perm->[ $i ] < $perm->[ $i + 1 ] );
	    $ok = 0 if ( $chars[ $i ] eq 'I' && $perm->[ $i ] > $perm->[ $i + 1 ] );
	    last if ! $ok;
	}

	return $perm if $ok;
  }

  return undef;
   
$CODE$
LANGUAGE plperlu;
