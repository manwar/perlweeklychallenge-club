#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a text file name $file and range $A - $B where $A <= $B.
Write a script to display lines range $A and $B in the given file.
Example
Input: $ cat input.txt
     L1
     ...
     L100

$A = 4 and $B = 12
Output:
     L4
     ...
     L12
=cut

use File::Spec;
my $FROM = shift || 4;
my $TO   = shift || 12;

my $tempfile = File::Spec->catfile(File::Spec->tmpdir(), 'input.txt');


{
     open my $out, ">", $tempfile or die "$!";
     for my $i ( 1 .. 100 )
     {
          print {$out} "L${i}", $/;
     }
}

{

     open my $in, "<", $tempfile or die "$!";


     while ( my $line = <$in> )
     {
          next if $. < $FROM;

          last if $. > $TO;
          print $line;
     }
}

unlink $tempfile or die "$!";