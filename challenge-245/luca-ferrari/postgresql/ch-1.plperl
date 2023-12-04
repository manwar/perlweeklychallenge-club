--
-- Perl Weekly Challenge 245
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
--

CREATE SCHEMA IF NOT EXISTS pwc245;

CREATE OR REPLACE FUNCTION
pwc245.task1_plperl( text[], int[] )
RETURNS SETOF text
AS $CODE$
   my ( $langs, $popularity ) = @_;

  die "Not same length arrays!" if ( $langs->@* != $popularity->@* );

   my $sorting = {};

    for my $index ( 0 .. $popularity->@* - 1 ) {
        $sorting->{ $popularity->[ $index ] } = $langs->[ $index ];
    }

    for ( sort { $b <=> $a } $popularity->@* ) {
        return_next( $sorting->{ $_ } );
    }

   return undef;

$CODE$
LANGUAGE plperl;
