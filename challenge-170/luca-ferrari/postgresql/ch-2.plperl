-- Perl Weekly Challenge 170
-- Task 2

create table if not exists a( a int, b int );
truncate table a;
insert into a values (1,2), (3,4);
create table if not exists b( a int, b int );
truncate table b;
insert into b values (5,6), (7,8);

CREATE SCHEMA IF NOT EXISTS pwc170;

CREATE OR REPLACE FUNCTION
pwc170.task2_plperl( text, text )
RETURNS TABLE( a int, b int, c int, d int )
AS $CODE$
   my ( $table_a, $table_b ) = @_;
   elog( DEBUG, "Reading tables $table_a and $table_b" );

   my ( $rs_a, $rs_b );
   $rs_a = spi_exec_query( "SELECT a,b FROM $table_a" );
   $rs_b = spi_exec_query( "SELECT a,b FROM $table_b" );

   for my $row_a ( 0 .. $rs_a->{ processed } - 1 ) {
      elog( DEBUG, "Loop A $row_a out of " . $rs_a->{ processed } );
      my ($aa, $ab) = ( $rs_a->{ rows }[ $row_a ]->{ a }, $rs_a->{ rows }[ $row_a ]->{ b } );

      for my $row_b ( 0 .. $rs_b->{ processed } - 1 ) {
        elog( DEBUG, "Loop B $row_b out of " . $rs_b->{ processed } );
        my ($ba, $bb) = ( $rs_b->{ rows }[ $row_b ]->{ a }, $rs_b->{ rows }[ $row_b ]->{ b } );

        elog( DEBUG, "Computing $aa $ab X* $ba $bb" );
        my $result = {
         a => $aa * $ba,
         b => $aa * $bb,
         c => $ab * $ba,
         d => $ab * $bb,
        };
        return_next( $result );
      }
   }

   return undef;
$CODE$
LANGUAGE plperl;
