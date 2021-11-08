#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate sequence starting at 1. Consider the increasing sequence of integers which contain only 1's, 2's and 3's, and do not have any doublets of 1's like below. Please accept a positive integer $N and print the $Nth term in the generated sequence. 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131...
Example
Input: $N = 5  Output: 13
Input: $N = 10 Output: 32
Input: $N = 60 Output: 2223
=cut






use DB_File;
use FindBin qw($Bin);

use lib $Bin;
use LocalUtils;


my $searched_term = shift; 

die "Which term of the sequence?$/" 
     unless $searched_term and $searched_term = int($searched_term);

my $output = find_in_sequence($searched_term);

print $output, $/;

sub find_in_sequence
{
     my $term = $_[0];
     my $filename = "persistence";
     my @h ;


     my $answer;
     tie @h, "DB_File", "$Bin/$filename", O_RDWR|O_CREAT, 0666, $DB_RECNO
          or die "Cannot open file 'text': $!\n" ;

     $h[1] = 1;


     my $nth = $#h;

     if ( $term <= $nth )
     {
          $answer = $h[$term]; 
     }
     else
     {

          my $i = convert_to_dec($h[$nth], 4); # LocalUtils.

          $i++;
          $nth++;
          while ( $nth <= $term )
          {
               my $seq = convert_from_dec($i, 4); # LocalUtils.
               if ( $seq =~ /0|1{2,}/) 
               { 
                    $i++; next; 

               }
               else
               {
                    $h[$nth] = $seq;
                    $nth++;
                    $i++;
               }
          }

          $answer = $h[$term];
     }
     untie @h;
     return $answer;
}