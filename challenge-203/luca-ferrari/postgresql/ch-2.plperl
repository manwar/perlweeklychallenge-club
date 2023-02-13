--
-- Perl Weekly Challenge 203
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
--

CREATE SCHEMA IF NOT EXISTS pwc203;

CREATE OR REPLACE FUNCTION
pwc203.task2_plperl( text, text )
RETURNS VOID
AS $CODE$
   use File::Find;
   use File::Path qw/make_path/;
   
   my ( $src, $dst ) = @_;
   my @paths;
   
   my $directory_scanner = sub {
      return if ! -d $_;
      return if $_ =~ /^\,{1,2}$/;
      push @paths, "$dst/$_";
   };


   find( { wanted => $directory_scanner } , $src );

   for ( @paths ) {
       make_path( $_ );
   }

   return;

$CODE$
LANGUAGE plperlu;
