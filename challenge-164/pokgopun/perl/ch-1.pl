use strict;
use warnings;

my $n = @ARGV && $ARGV[0] =~ /^\d+$/ ? $ARGV[0]: 1000;
$n = 10_000_000 if $n > 10_000_000;
$n--;
printf "%s\n", join(", ", ppld($n));

sub ppld{
	my $n = shift;
	my %pld;
	foreach (2..$n){
		my $i = int(length($_)/2);
		$pld{$_}++ if $i==0 || $i > 0 && $_ =~ /^(\d{$i})\d?(\d{$i})$/ && $1 eq join "", reverse split //, $2;
	}
	#printf "%s\n", join(", ", sort{$a<=>$b} keys %pld);
	foreach (2..sqrt($n)){
		my $i = $_**2;
		{
			last if $i > $n;
			delete $pld{$i};
			$i += $_;
			redo;
		}
	}
	return sort{$a<=>$b} keys %pld;
}
