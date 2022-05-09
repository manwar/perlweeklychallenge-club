use strict;
use warnings;

my %happy;
my $n = @ARGV && $ARGV[0] =~ /^\d+$/ ? $ARGV[0]: 8;
$n = 100_000 if $n > 100_000;

my $limit = 1000_000;
print "1";
$n--;
foreach (2..$limit){
	last unless $n;
	print ", $_" if isHappy($_) && $n--;
}
print "\n";

sub isHappy{
	my $i = shift;
	#$i =~ s/0//g;
	return $happy{$i} if defined $happy{$i};
	if (grep{$_==$i} @_){
		$happy{$_}=0 foreach @_;
		return 0;
	}
	my $sum = eval(join(" + ", map{$_*$_} split //,$i));
	push @_, $i;
	if ($sum==1){
		$happy{$_}=1 foreach @_;
		return 1;
	}
	return isHappy($sum,@_);
}
