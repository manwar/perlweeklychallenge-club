use strict;
use warnings;

my @n;
push @n, @ARGV ? @ARGV : (145,123);
foreach my $n (@n) {
	my @digit = $n =~ /(\d)/g;
	my $res0 = join(" + ", map{$_."!"} @digit); 
	my $res1 = join(" + ", map{&factorial($_)} @digit);
	my $res = eval($res1) == $n ? 1 : 0;
	
	printf "Input: \$n = %s\nOutput: %s\n\n\tSince %s => %s %s %s\n\n", $n, $res, $res0, $res1, $res ? "=" : "<>", $n;
}
sub factorial { 
	my $n = shift;
	return $n==0 ? 1 : eval(join(" * ", 1..$n));
}

