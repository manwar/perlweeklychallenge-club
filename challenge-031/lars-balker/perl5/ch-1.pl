sub div {
	my ($num, $denom) = @_; 
	my $res; 
	eval { $res = $num / $denom; }; 
	return $res // "divide by zero error"
}

say div(1,0);
say div(1,1)'
