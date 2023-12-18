--
-- Perl Weekly Challenge 248
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
--

CREATE SCHEMA IF NOT EXISTS pwc248;

CREATE OR REPLACE FUNCTION
pwc248.task1_plperl( text, text )
RETURNS TABLE( c char, distance int )
AS $CODE$
   my ( $string, $char ) = @_;

   die "Use a single char!" if ( length( $char ) > 1 );
   die "Not matching at all!" if ( $string !~ / $char /x );


   my $min = sub {
      my $current_min = $_[ 0 ];
      shift;
      for ( @_ ) {
      	  $current_min = $_ if ( $_ < $current_min );
      }

      return $current_min;
   };

   my @distances;
   my @matching;

   my @letters = split //, $string;
   for ( 0 .. @letters - 1 ) {
       next if $letters[ $_ ] ne $char;
       push @matching, $_;
   }


   for my $me ( 0 .. @letters - 1 )  {

       $distances[ $me ] = 0 if ( $letters[ $me ] eq $char );
       $distances[ $me ] = $min->( map { abs( $me - $_ ) } @matching ) if ( $letters[ $me ] ne $char );

       return_next( { c => $letters[ $me ],
     		      distance => $distances[ $me ] } );

   }

   return undef;

$CODE$
LANGUAGE plperl;
