#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a text file. Write a script to transpose the contents of the given file.
Input File
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f

Output:
name,Mohammad,Joe,Julie,Cristina
age,45,20,35,10
sex,m,m,f,f
=cut

use Text::CSV_XS qw(csv);


my $aoa = csv(in => *DATA, sep_char => ',');
my $transposed = transpose($aoa);
print_matrix($transposed);

sub transpose
{
     my $aoa = $_[0];
     my $output;
     for my $i ( 0 .. $#$aoa )
     {
          for my $j ( 0 .. $#{$aoa->[$i]} )
          {
               $output->[$j][$i] = $aoa->[$i][$j];
          }
     }
     return $output;


}



sub print_matrix
{
     my $mtr = $_[0];
     for my $i ( 0 .. $#$mtr )

     {
          print join(',', @{$mtr->[$i]}), $/;
     }
}





__END__
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f