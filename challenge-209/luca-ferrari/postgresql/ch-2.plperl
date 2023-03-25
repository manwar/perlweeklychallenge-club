--
-- Perl Weekly Challenge 209
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
--

CREATE SCHEMA IF NOT EXISTS pwc209;

DROP TABLE IF EXISTS pwc209.accounts;
CREATE TABLE IF NOT EXISTS pwc209.accounts ( a_name text, a_email text );
TRUNCATE TABLE pwc209.accounts;
INSERT INTO pwc209.accounts
VALUES ( 'A', 'a1@a.com' )
, ('A', 'a2@a.com' )
, ( 'B', 'b@b.com'  )
, ( 'A', 'a3@a.com' )
, ( 'A', 'a1@a.com'  );


CREATE OR REPLACE FUNCTION
pwc209.task2_plperl()
RETURNS TABLE( a text, e text[] )
AS $CODE$

   my $result_set = spi_exec_query( " select a_email, count(*) from pwc209.accounts group by a_email having count(*) > 1 " );



   my @duplicated_emails;
   for  ( 0 .. $result_set->{ processed } - 1 ) {
      my $row = $result_set->{ rows }[ $_ ];
      push @duplicated_emails,  $row->{ a_email }; 
   }


 
   my $query = sprintf qq/ with accs AS ( select distinct a_name from pwc209.accounts where a_email IN (%s) )
select a.a_name, a_email  from pwc209.accounts a, accs where a.a_name = accs.a_name /
, join( ',',  map( { "'$_'"  } @duplicated_emails ) );
   $result_set = spi_exec_query( $query );

   my $to_return = {};
    for  ( 0 .. $result_set->{ processed } - 1 ) {
      my $row = $result_set->{ rows }[ $_ ];
      return_next( $to_return ) if ( $to_return->{ a } && $to_return->{ a } ne $row->{ a_name } );

      $to_return->{ a } = $row->{ a_name };
      next if ( grep { $_ eq $row->{ a_email } } $to_return->{ e }->@* );
      push $to_return->{ e }->@*, $row->{ a_email };
    }   

   return_next( $to_return );
return undef;
$CODE$
LANGUAGE plperl;
