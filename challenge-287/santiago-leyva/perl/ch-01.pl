
use strict;
use warnings;

my @passwords = ('a',"aB2","PaaSW0rd","Paaasw0rd","aaaaa","axmlsa");

foreach(@passwords){
  print "--> checking password $_ | ";
  my $result = checkPassword($_);
  print "changes that need to be made: $result\n";
}

sub checkPassword {
  my $pass = shift;
  my $length = length($pass);
  my $changes = 0;
  my $least6 = $pass =~ /.{6,}/;
  my $lower = $pass =~ /(?=.*[a-z])/;
  my $upper = $pass =~ /(?=.*[A-Z])/;
  my $digit = $pass =~ /(?=.*\d)/;
  my $repeated = check3Repeated($pass);

  #check if the length of the password is 6 or greater
  if(!$least6){
    my $remain = 6-$length;
    if($remain == 1 and (!$lower or !$upper or !$digit)){
      $changes++;
      $changes += $remain;
      return $changes;
    }
    $changes += $remain;
    return $changes if $remain > 1;
  }
  if(!$lower){
    $changes += 1;
  }
  if(!$upper){
    $changes += 1;
  }
  if(!$digit){
    $changes += 1;
  }
  if($repeated){
    $changes += 1;
  }
  return $changes;
}

sub check3Repeated {
  my $s = shift;
  my @char = split("",$s);
  my %map;
  foreach(@char){
    if(!exists($map{$_})){
      $map{$_} = 1;
    }else{
      $map{$_} += 1;
    }
  }
  my @values = sort {$a <=> $b} values %map;
  if($values[-1] >= 3){
    return 1;
  }
  return 0;
} 