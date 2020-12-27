#!/c/Perl/bin/perl.exe
use strict;
use warnings;
my @data=('abc','xyz','abb','xyy','sum','add');

if ($#ARGV < 0 )
  { run_given_dataset() }
elsif ($#ARGV == 1 )
  { test_commandline_args() }
else
  { print "Error: unimplemented\n" }

sub run_given_dataset
{
foreach (1..3)
  {
  my $retval = check_isomorphism(shift(@data),shift(@data));
  # print "***\n@data\n***\n";
  if ($retval)
    { print "Output: 1\n----\n"; }
  else
    { print "Output: 0\n----\n"; }
  }
}

sub test_commandline_args
  {
  my $retval = check_isomorphism($ARGV[0],$ARGV[1]); 
  if ($retval)
    { print "Output: 1\n----\n"; }
  else
    { print "Output: 0\n----\n"; }
  }

sub check_isomorphism
  {
  my $var1=shift;
  my $var2=shift;
  print "Input: \$A = \"$var1\"; \"\$B\" = \"$var2\"\n";
  my (%isomapAB,%isomapBA,$char1,$char2,$x);
  my $len=length($var1);
  my $len2=length($var2);
  if ($len != $len2) { return 0 }
  foreach $x (1..$len)
    {
    $char1=substr($var1,$x-1,1);
    $char2=substr($var2,$x-1,1);
    if (exists $isomapAB{$char1} )
      {
      if ($char2 ne $isomapAB{$char1})
        { return 0 }
      }
    else
      {
      $isomapAB{$char1} = $char2;
      }
    if (exists $isomapBA{$char2} )
      {
      if ($char1 ne $isomapBA{$char2})
        { return 0 }
      }
    else
      {
      $isomapBA{$char2} = $char1;
      }
    }
  return 1;
}
