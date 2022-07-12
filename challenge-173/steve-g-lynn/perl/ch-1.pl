#!/usr/bin/perl

print is_esthetic(5_456),"\n";   #1
print is_esthetic(120),"\n";	#0


sub is_esthetic {
	my ($number)=@_;
	$number =~ s/_//g; #-- get rid of thousands separators if any
	($number =~ /^\d+$/) || (return 0); #-- false if not a number
	for my $i (0 .. (length($number)-2)) {
		( (substr($number,$i+1,1)==(substr($number,$i,1)+1)) || 
		(substr($number,$i+1,1)==(substr($number,$i,1)-1)) ) ||
		return 0;
	}
	return 1; 
}
