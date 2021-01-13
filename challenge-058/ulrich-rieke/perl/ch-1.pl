#!/usr/bin/perl ;
use strict ;
use warnings ;

#lexicographically compare the strings by first removing any leading
#zeroes and the periods and underscores , then conditionally check
#for underscores to decide the ordering

sub compareElementwise {
  my $v1 = shift ;
  my $v2 = shift ;
  $v1 =~ s/\A0*(.+)/$1/ ;
  $v2 =~ s/\A0*(.+)/$1/ ;
  my @ar1 = split (/[_.]/ , $v1 ) ;
  my @ar2 = split (/[_.]/ , $v2 ) ;
  my $string1 = join ( '' , @ar1 ) ;
  my $string2 = join ( '' , @ar2 ) ;
  if ( $string1 lt $string2 ) {
      return -1 ;
  }
  if ( $string1 gt $string2 ) {
      return 1 ;
  }
  if ( $string1 eq $string2 ) {
      if ( $v1 =~ /_/ && $v2 !~ /_/ ) {
    return -1 ;
      }
      if ( $v1 !~ /_/ && $v2 =~ /_/ ) {
    return 1 ;
      }
      if ( $v1 eq $v2 ) {
    return 0 ;
      }
  }
}

my @v1 = ( "0.1" , "2.0" , "1.2" , "1.2.1" , "1.2.1" ) ;
my @v2 = ( "1.1" , "1.2" , "1.2_5" , "1.2_1" , "1.2.1" ) ;
my $len = $#v1 ;
for my $i ( 0..$len ) {
  my $num = compareElementwise( $v1[ $i ] , $v2[ $i ] ) ;
  print "v1: $v1[$i],  v2:  $v2[$i] ,  result : $num\n"
}
