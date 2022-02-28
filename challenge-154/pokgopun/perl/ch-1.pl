use strict;
use warnings;

my $e = "PERL";

my $exist = "PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP";

my $n = length($e);
sub test{
	my ($c,$e) = @_;
	{
		last if $e;
		print "$c\n" if index($exist,$c) < 0;
		return;
	}
	foreach (0..length($e)-1){
		my $et = $e;
		my $ct = $c;
		$ct .= substr($et,$_,1);
		$et = substr($et,0,$_).substr($et,$_+1,length($et)-$_);
		&test($ct,$et);
	}
}

&test("",$e);
