--
-- Perl Weekly Challenge 227
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
--

CREATE SCHEMA IF NOT EXISTS pwc227;

CREATE OR REPLACE FUNCTION
pwc227.task2_plperl( text, text, text )
RETURNS text
AS $CODE$
   use v5.20;
   my ( $left, $operator, $right ) = @_;

   my $symbols = {
          1 => 'I',
	  4 => 'IV',	  
	  5 => 'V',	  
	  9 => 'IX',	  
	 10 => 'X',	  
	 40 => 'XL',
	 50 => 'L',
	 90 => 'XC',
	 100 => 'C',
	 400 => 'CD',
	 500 => 'D',
	 900 => 'CM',
	1000 => 'M'
      };


   my $unsymbols = {};
   $unsymbols->{ $symbols->{ $_ } } = $_   for ( keys $symbols->%* );



   use Sub::Recursive;

   my $to_roman = recursive {
      my ( $number ) = @_;

      


      return '' if ! $number;

      for my $arabic ( sort  { $b <=> $a } keys $symbols->%* ) {
      	  if ( $number >= $arabic ) {
	     return $symbols->{ $arabic } . $REC->( $number - $arabic );
	  }
      }

   };


   my $to_arabic = sub {
      my ( $number ) = @_;
      my $value = 0;
      for my $roman ( reverse sort keys $unsymbols->%* ) {
      	  $value += $unsymbols->{ $roman } while $number =~ s/^$roman//i;
      }

      return $value;
   };


   my $result = 0;
   given ( $operator ) {
   	 when (/\+/) { $result = $to_arabic->( $left ) + $to_arabic->( $right ); }
    	 when (/\-/) { $result = $to_arabic->( $left ) - $to_arabic->( $right ); }
   	 when (/\//) { $result = $to_arabic->( $left ) / $to_arabic->( $right ); }
   	 when (/\*/) { $result = $to_arabic->( $left ) * $to_arabic->( $right ); }	 
   }

   return undef if ( $result < 1 );
   return $to_roman->( $result );

$CODE$
LANGUAGE plperlu;
