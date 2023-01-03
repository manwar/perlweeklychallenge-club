CREATE SCHEMA IF NOT EXISTS pwc198;

CREATE OR REPLACE FUNCTION
pwc198.task1_plperl( int[] )
RETURNS int
AS $CODE$
  my ( @list ) = sort $_[0]->@*;
  my $pairs = {};
  for ( 1 .. @list - 1 ) {
      if ( ( $list[ $_ ] - $list[ $_ - 1 ] ) == ( $list[ $_ + 1 ] - $list[ $_ ] ) ) {
      	 push $pairs->{ $list[ $_ ] - $list[ $_ - 1 ] }->@*, $list[ $_ ], $list[ $_ - 1 ], $list[ $_ + 1 ], $list[ $_  ];
      }	 
  }

  my $max = 0;
  for ( keys $pairs->%* ) {
      $max = $_ if $_ > $max;
  }

  return scalar $pairs->{ $max }->@*;
$CODE$
LANGUAGE plperl;
