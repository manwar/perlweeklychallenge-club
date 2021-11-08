#!perl
use strict;
use warnings FATAL => qw(all);

sub convert_from_dec
{
     my @digits = ( 0 .. 9 );
     my $num = $_[0];

     my $base = $_[1] // 2;

     my $output = '';

     while ( $num > 0 )
     {
          my $rem = $num % $base;
          $output = $digits[$rem] . $output;
          $num = ( $num - $rem ) / $base;
     }
     return $output;
}

sub convert_to_dec
{
     my @digits = ( 0 .. 9 );

     my $str = $_[0];
     my $base = $_[1] // 2;
     my $output = 0;

     for my $chr ( split(//,$str) )
     {
          $output *= $base;
          $output += $digits[$chr];
     }
     return $output;
}




1;