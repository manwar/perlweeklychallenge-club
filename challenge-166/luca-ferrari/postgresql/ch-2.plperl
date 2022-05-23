-- Perl Weekly Challenge 166
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc166;

CREATE OR REPLACE FUNCTION
pwc166.task2_plperl( text, text, text )
RETURNS TABLE( dir_a text , dir_b text , dir_c text )
AS $CODE$
my ( $dir_a, $dir_b, $dir_c ) = @_;
my $files = {};
my @dirs;
my $index = -1;

for my $current_dir ( @_ ) {
  elog( INFO, "Opening $current_dir" );
  $index++;
  push @dirs, "dir_" . ( 'a' .. 'c' )[ $index ];
  opendir my $dir, $current_dir;
  while ( my $entry = readdir( $dir ) ) {
        my $filename = $entry . ( -f "$current_dir/$entry" ? "" : "/" );
        push $files->{ $filename }->@*, "dir_" . ( 'a' .. 'c' )[ $index ];
  }
  closedir $dir;
}

for my $filename ( sort keys( $files->%* ) ) {
    next if scalar( $files->{ $filename }->@* ) == scalar @_;
    my $hash = {};

    $hash->{ $_ } = undef for @dirs;
    for my $dir ( $files->{ $filename }->@* ) {
        $hash->{ $dir } = $filename;
    }

return_next( $hash );
}


return undef;

$CODE$
LANGUAGE plperlu;

/*
testdb=# select * from pwc166.task2_plperl( '/tmp/dir_a', '/tmp/dir_b', '/tmp/dir_c' );
INFO:  Opening /tmp/dir_a
INFO:  Opening /tmp/dir_b
INFO:  Opening /tmp/dir_c
     dir_a      |      dir_b      |      dir_c      
----------------+-----------------+-----------------
 Comic_Sans.ttf | Comic_Sans.ttf  | 
                | Courier_New.ttf | Courier_New.ttf
 Georgia.ttf    |                 | 
                |                 | Monaco.ttf
                | Tahoma.ttf      | 
 other_fonts/   |                 | 

*/
