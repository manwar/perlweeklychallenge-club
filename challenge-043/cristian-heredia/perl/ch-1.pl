#!/usr/bin/perl

#Array with posibles values
my @values = (1, 2, 3, 4, 6);
my @red = (9, $a);
my @green = ($a, 5, $b);
my @black = ($b, $q, $c);
my @yellow = ($c, 7, $d);
my @blue = ($d, 8);

#others variables
my $a; 
my $b; 
my $c; 
my $d; 
my $q;
my @total = (11);

$a = @total[0] - @red[0];
@red[1] = $a;
validate($a);
print "\nValors of red:\n";
for (my $j = 0; $j < @red; $j++) {
	print "@red[$j],";
}
print "\n";

@green[0] = $a;
$b = @total[0] - @red[1] - @green[1];
validate($b);
@green[2] = $b;
print "\nValors of green:\n";
for (my $j = 0; $j < @green; $j++) {
	print "@green[$j],";
}
print "\n";

$d = @total[0] - @blue[1];
validate($d);
@blue[0] = $d;
print "\nValors of blue:\n";
for (my $j = 0; $j < @blue; $j++) {
	print "@blue[$j],";
}
print "\n";

@yellow[2] = $d;
$c = @total[0] - @yellow[1] - @yellow[2];
validate($c);
@yellow[0] = $c;
print "\nValors of yellow:\n";
for (my $j = 0; $j < @yellow; $j++) {
	print "@yellow[$j],";
}
print "\n";

@black[0] = $b;
@black[2] = $c;
$q = @total[0] - @black[0] - @black[2];
@black[1] = $q;
validate($q);
print "\nValors of black:\n";
for (my $j = 0; $j < @black; $j++) {
	print "@black[$j],";
}
print "\n";


sub validate {
	$valor = shift;
	my $valide;
	for (my $j = 0; $j < @values; $j++) {
		if (@values[$j] == $valor) {
			$valide = "KO";
			
		}
		else {
			$valide = "OK";
			last;
		}
	}
	
	if ($validate == KO) {
		print "The number $valor is one of the given.";
	}
	else {
		print "The number $valor isn't one of the given.";	
	}
	
}
