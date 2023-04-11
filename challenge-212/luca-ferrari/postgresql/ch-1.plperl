--
-- Perl Weekly Challenge 212
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
--

CREATE SCHEMA IF NOT EXISTS pwc212;



CREATE OR REPLACE FUNCTION
pwc212.task1_plperl( text, int[] )
RETURNS text
AS $CODE$
  my ( $string, $jumps ) = @_;
  my @alphabet = 'a' .. 'z';

  my $find_index = sub {
     my ( $letter ) = @_;
     for my $index ( 0 .. scalar( @alphabet ) ) {
     	 return $index if ( $alphabet[ $index ] eq $letter );
     }
  };

  my $offset = 0;
  my @word;
  for my $letter ( split //, $string ) {
      my $index = $find_index->( $letter );
      $index += $jumps->[ $offset++ ];
      $index %= @alphabet;
      push @word, $alphabet[ $index ];
  }  

  return join( '', @word );

$CODE$
LANGUAGE plperl;
