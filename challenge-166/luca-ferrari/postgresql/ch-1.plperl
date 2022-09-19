-- Perl Weekly Challenge 166
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc166;

CREATE OR REPLACE FUNCTION
pwc166.task1_plperl( text, int, int )
RETURNS SETOF text
AS $CODE$
my ($filename, $min, $max) = @_;
my $line;
my $substitutions = { o => 0,
                      l => 1,
                      i => 1,
                      s => 5,
                      t => 7 };

open my $file, "<", $filename;

while ( $line = <$file> ) {
      chomp $line;
      next if length( $line ) < $min || length( $line ) > $max;

      $line = lc $line;
      next if $line !~ /^[a..folist]+$/;

      for my $k ( keys( %$substitutions ) ) {
          $line =~ s/$k/$substitutions->{ $k }/g;
      }

      return_next( $line );
}

close $file;
return undef;

$CODE$
LANGUAGE plperlu;


/*
testdb=# select * from pwc166.task1_plperl( '/tmp/dictionary.txt', 2, 8 ) limit 10;
 task1_plperl 
--------------
 af10a7
 af007
 a11
 a115
 a1a5
 a11a5
 a11
 a1107
 a11075
 a10f7
(10 rows)

*/
