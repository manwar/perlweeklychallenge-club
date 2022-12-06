-- Perl Weekly Challenge 194
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc194;

CREATE OR REPLACE FUNCTION
pwc194.task1_plperl( text )
RETURNS int
AS $CODE$
 my ($what) = @_;

 if ( $what =~ / ^ ([\d?]) ([\d?]) : ([\d?]) ([\d?]) $ /x ) {
    if ( $1 eq '?' ) {
       return 9;
    }
    elsif ( $2 eq '?' ) {
      return 3 if $1 == 2;
      return 9;
    }
    elsif ( $3 eq '?' ) {
      return 5;
    }
    else {
      return 9;
    }
 }

return undef;

$CODE$
LANGUAGE plperl;
