use strict;
use warnings;

my @sample = @ARGV > 1 && join("",@ARGV) =~ /^\d+$/ ? ([@ARGV]) : ([1,2,3],[2,3,4]);
foreach (@sample){
	printf "Input: \@n = (%s)\nOutput: %d\n\n", join(", ",@$_), sumBitwise(@$_);
}

sub sumBitwise{
	return eval( join(" + ", map{$_->[0] & $_->[1]} @{getCombo(2,@_)} ) );
}

sub getCombo{
	my $n = shift;
	my $res = [];
	cTree([],$n,[@_],$res);
	return $res;
}	

sub cTree{
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

