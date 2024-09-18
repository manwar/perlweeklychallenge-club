use Data::Dumper;
use strict;

my @input = ("1","a",".","1.2e4.2","-1.","+1E-8","44","1203ñ{}");
#my @input = ("-1.","+1E-8","44","1203ñ{}");

foreach(@input){
  my $result = checkNumber($_);
  print "for $_ -> $result \n";
}

sub checkNumber {
  my $num = shift;

  my @N = split(/\./,$num);
  my $length = scalar  @N;
  if($length == 1){
    return "True" if ($num =~ /\-*\+*\d+\.*$/g or $num  =~ /^\d+e|E\d+$/);
  }elsif($length == 2){
    return "True" if ( ($num =~ $N[0] =~ /^\d+$/ and $N[1] =~ /^\d+$/ ) or ($N[0] =~ /^\d+$/ and $N[1] =~ /^\d+e\d+$|E\d+$/) );
  }
  return "false";
}