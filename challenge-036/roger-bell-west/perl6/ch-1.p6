#! /usr/bin/perl6

# Write a program to validate given Vehicle Identification Number (VIN).

my %cvalue;
map {%cvalue{$_}=$_}, (0..9);
my $base=ord('A');
for (slip('A'..'H'),slip('J'..'N'),'P','R') -> $char {
  %cvalue{$char}=(ord($char)-$base)%9+1;
}
for ('S'..'Z') -> $char {
  %cvalue{$char}=(ord($char)-$base)%9+2;
}
my $valid='^<[' ~ join('',keys %cvalue) ~ ']>*$';

my @weight=(slip(2..9),0,10,slip(2..8)).reverse;

for @*ARGS -> $vin {
  unless ($vin.chars==17) {
    print "$vin is not 17 characters\n";
    next;
  }
  unless ($vin ~~ /<$valid>/) {
    print "$vin contains invalid characters\n";
    next;
  }
  my $check=0;
  for (0..16) -> $ix {
    $check+=%cvalue{substr($vin,$ix,1)}*@weight[$ix];
  }
  $check%=11;
  if ($check==10) {
    $check='X';
  }
  if (substr($vin,8,1) ne $check) {
    print "$vin does not pass check-digit verification (may be valid non-NA)\n";
    next;
  }
  print "$vin is valid.\n";
}
