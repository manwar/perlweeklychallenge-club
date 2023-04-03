--
-- Perl Weekly Challenge 210
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-210/>
--

CREATE SCHEMA IF NOT EXISTS pwc210;

CREATE OR REPLACE FUNCTION
pwc210.task1_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = @_;
  my $max = 0;
  my @removed;
  
  for ( $list->@* ) {
     $max = $_ if( $max < $_ );
  }

  for my $index ( 2 .. $max ) {
     next if ( grep { $_ == $index } @removed );
     next if ( grep { $_ == ( $index + 1 ) } @removed );
     next if ( grep { $_ == ( $index - 1 ) } @removed );

     push @removed, ( grep( { $_ == $index } $list->@* ),
                      grep( { $_ == ( $index + 1) } $list->@* ),
		      grep( { $_ == ( $index - 1) } $list->@* ) );
  }

  my $sum = 0;
  $sum += $_ for ( @removed );
  return $sum;
$CODE$
LANGUAGE plperl;
