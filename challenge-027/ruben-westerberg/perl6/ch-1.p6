#!/usr/bin/env perl6
my @l;
while @l < 2  {
	my @p=split " ", prompt("Enter line"~(@l+1)~":  x1 y1 x2 y2\n"), :skip-empty;
	if (@p==4) {
		push @l, {px=>[@p[0,2]],py=>[@p[1,3]],m=>Any,c=>Any};
	}
	else {
		print "not a valid line! \n";
	}
}

for @l {
	$_<m>=($_<py>[1]-$_<py>[0])/($_<px>[1]-$_<px>[0]);
	$_<c>=$_<py>[0]- ($_<m>*$_<px>[0]); 
}
my $x=(@l[0]<c>-@l[1]<c>)/( @l[1]<m>-@l[0]<m>);
my $y=@l[0]<m>*$x+@l[0]<c>;

put "Intercept point: $x, $y";
