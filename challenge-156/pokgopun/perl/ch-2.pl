use strict;
use warnings;
use Data::Dumper;

my $n = shift;
$n = 12 unless $n && $n =~ /^\d+$/;

my @d =  &getDivisors($n);
#printf "%s\n", join(", ", @d);
my $sum = eval(join(" + ",@d));
my $o = 0;
{
	last unless $sum > $n;
	$o = 1;
	for my $i (2..$#d) {
		my $ds = [];
		&cTree([],$i,[@d],$ds);
		if (&isSumsEqualN($n,$ds)){
			$o = 0;
			last;
		}
	}
}
#printf "Input: \$n = %s, Output: %s\n", $n, $o;
printf "Input: \$n = %s\n", $n;
printf "Output: %s\n", $o;

sub isSumsEqualN{
	my($n,$ds) = @_;
	for (@$ds) {
		my $sum = eval(join(" + ", @$_));
		if ($sum == $n){
			return 1;
		}
	}
	return 0;
}
sub cTree {
		my($c,$n,$e,$res) = @_;
		if ( @$c == $n || @$c + @$e == $n ) {
			my @res = @{[@$c,@$e]}[0..$n-1];
			if ($res) {
				push @$res, \@res;
			} else {
				printf "%s\n", join(", ",@res);
			}
		} else {
			{
				my $ct = [@$c,@{$e}[0]];
				shift @$e if @$e;
				&cTree($ct,$n,[@$e],$res);
				redo if @$ct + @$e > $n;
			}
		}
	}
sub getDivisors() {
	my $n = shift;
	my @d;
	my $i;
	{
		$i++;
		push @d, $i unless $n % $i;
		redo if $i < int($n/2);
	}
	return @d;
}
