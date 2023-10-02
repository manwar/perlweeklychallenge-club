--
-- Perl Weekly Challenge 234
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
--

CREATE SCHEMA IF NOT EXISTS pwc234;

CREATE OR REPLACE FUNCTION
pwc234.task1_plperl( text[] )
RETURNS SETOF char
AS $CODE$
  my ( $words ) = @_;

  my $chars = {};

  for my $current_word ( $words->@* ) {
      for my $current_char ( sort split //, $current_word ) {
            if ( ! grep { $_ eq $current_word } $chars->{ $current_char }->@* ) {
	     push $chars->{ $current_char }->@*, $current_word;
	  }
      }
  }

  for my $current_char ( keys $chars->%* ) {
      return_next( $current_char ) if ( $chars->{ $current_char }->@* == scalar $words->@* );
  }

  return undef;
$CODE$
LANGUAGE plperl;
