use strict;
use warnings;

my $val;
my $sum;

while(1){	
$sum = 1 . ex() . 2 . ex() . 3 . ex() . 4 . ex() . 5 . ex() . 6 . ex() . 7 . ex() . 8 . ex() . 9;
$val = eval ($sum);
last if ($val == 100);
}

print "$sum\n";
print eval($sum)."\n";

sub ex {
	my $sign = int(rand(3));
	if($sign == 0) {
    my $sym = "+";
	return $sym;
    } else {
	if($sign == 1) {
	my $sym = "-";
	return $sym;
    } else {
	if($sign == 2) {
	my $sym = "";
	return $sym;
   }
  }
 }
}
