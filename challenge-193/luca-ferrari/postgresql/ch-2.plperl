-- Perl Weekly Challenge 193
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc193;

CREATE OR REPLACE FUNCTION
pwc193.task2_plperl( text )
RETURNS text
AS $CODE$
 my ( $current_string ) = @_;
 my @chars = split '', $current_string;
 my $counter = 0;
 my %translations = map {  $_ => $counter++ } ( 'a' .. 'z' );

 my @values = map { $translations{ $_ } } @chars;

 my @difference;
 for my $index ( 1 .. length( $current_string )  ) {
   push @difference, $chars[ $_ ] - $chars[ $_ - 1 ];
 }

 if ( scalar( grep { $_ % 2 != 0 } @difference ) == @difference ) {
    return $current_string;
 }
 else {
   return undef;
 }

$CODE$
LANGUAGE plperl;
