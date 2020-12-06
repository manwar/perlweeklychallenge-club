#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display matrix as below with numbers 1 - 9. Please make sure numbers are used once.
[ a b c ]
[ d e f ]
[ g h i ]
So that it satisfies the following: a + b + c = 15 d + e + f = 15  + h + i = 15 a + d + g = 15 b + e + h = 15
c + f + i = 15 a + e + i = 15 c + e + g = 15
=cut


use List::Util qw(sum all);

my $n = 3;
my $magic = $n * ($n * $n + 1)/ 2; # 15 for 3x3 matrix.
my $aref = find($n);

print_mtr($aref) if check($aref, $magic);

sub find
{
     my $n = $_[0];

     my $aref = _fill($n);
     my $r = 0;
     my $c = int $n/2;
     my $counter++;
     while ( grep { not defined($_)} map {@$_} @$aref )
     {
          $aref->[$r][$c] = $counter++;

          if ( ($r - 1) < 0 and ($c - 1) < 0 )
          {
               $r++;
          }


          elsif ( ($r - 1) < 0 )
          {
               $r = $n - 1;

               $c--;
          }
          elsif ( ($c - 1) < 0 )
          {

               $c = $n - 1;
               $r--;
          }
          elsif ( $aref->[$r - 1][$c - 1])
          {
               $r++;
          }
          else
          {
               $r--;
               $c--;
          }
     }
     return $aref;
}



sub check
{
     my ($aref, $check) = @_;
     my $rows = all { sum(@$_) == $check } @$aref;
     my $cols = all {$_ == 1}
          (map{ my $i = $_; all{sum( map{ $_->[$i]} @$aref ) == $check} } 
               0 .. $#$aref);


     my $diag_1 = sum( map { $aref->[$_][$_] } 0 .. $#$aref) == $check;
     my $diag_2 = sum( map { $aref->[$_][$#$aref - $_] } 0 .. $#$aref) == $check;
     return ($rows and $cols and $diag_1 and $diag_2);
}

sub print_mtr
{
     my $aref = $_[0];

     for my $i ( 0 .. $#$aref )
     {
          print join(' ', '[', join(" ", @{$aref->[$i]}), ']'), $/;
     }
}

sub _fill
{

     my $n = $_[0]; my $aref;
     for my $i ( 0 .. $n - 1 )
     {
          for my $j ( 0 .. $n - 1 )
          {
               $aref->[$i][$j] = undef;
          }

     }

     return $aref;
}