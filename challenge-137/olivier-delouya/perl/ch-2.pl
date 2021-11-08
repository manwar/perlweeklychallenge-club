#!perl perl137-2.pl.txt -lowerBound=10 -upperBound=1000 -maxIterations=500 -maxTerm=10000000 -maxTime=60s

use strict;
use Data::Dumper;

use Math::BigInt;

sub reverse_num
	{
	my $strnum = "$_[0]";
	my $numstr = '';
	for(my $i=length($strnum); $i>-1; $i--)
		{
		$numstr .= substr($strnum, $i, 1);
		}
	return Math::BigInt->new($numstr);
	}


my ($LowerBound, $UpperBound, $MaxIter, $MaxTerm) = (10, 1000, 500, 10000000);
my ($MaxTime, $TimeUnit);
	
foreach (@ARGV)
    {
    ($UpperBound = $1, next) if($_ =~ m/^\-upperBound\=(\d+)$/);
    ($LowerBound = $1, next) if($_ =~ m/^\-lowerBound\=(\d+)$/); 
    ($MaxIter    = $1, next) if($_ =~ m/^\-maxIterations\=(\d+)$/);
    ($MaxTerm    = $1, next) if($_ =~ m/^\-maxTerm\=(\d+)$/);
    (($MaxTime, $TimeUnit) = ($1, $2), next) if($_ =~ m/^\-maxTime\=(\d+)([smhDMY]?)$/);
    print STDERR  "$_: Unknown statement\n";
    }
    
my $BIMaxTerm = Math::BigInt->new($MaxTerm);
if(defined($MaxTime))
    {
    $TimeUnit = 's' if(!$TimeUnit);
    my %TimeUnits = ('s' => 1, 'm' => 60, 'h' => 3600, 'D' => 24*3600, 'M' => 24*3600*30, 'Y' => 24*3600*24*30*365);
    $MaxTime *= $TimeUnits{$TimeUnit};
    }	
	

num: for (; $LowerBound < $UpperBound; $LowerBound++)
	{
	for (my $time0=time(), my $iter=0, my $basenum=Math::BigInt->new($LowerBound); ; $iter++)
		{
		my $munesab = reverse_num($basenum);
		if($basenum->beq($munesab)) # ($basenum == $munesab)
			{
			print "$LowerBound is *not* a Lychrel number ($munesab after ", !$iter? 0 : $iter-1, " iterations in ", time()-$time0, "s)\n";
			next num;
			}
		if(++$iter > $MaxIter)
			{
			print "$LowerBound appears still to be a Lychrel number, after ", !$iter? 0 : $iter-1, " sum iterations in ", time()-$time0, "s)\n";
			next num;
			}	
		if($munesab->bgt($BIMaxTerm))
			{
			print "$LowerBound appears still to be a Lychrel number below $BIMaxTerm sum iterations in $iter iterations and ", time()-$time0, "s)\n";
			next num;
			}
		if(defined($MaxTime) && time()-$time0 >= $MaxTime)
		    {
			print "$LowerBound appears still to be a Lychrel number: reached $basenum within $MaxTime$TimeUnit, $iter iterations)\n";
			next num;
		    }
		$basenum->badd($munesab);
		if($basenum !~ /^\d+$/ || $basenum->is_inf() || $basenum->is_nan())
		    {
			print "$LowerBound appears still to be a Lychrel number: overflow ($basenum) within ", time()-$time0, "s and $iter iterations)\n";
			next num;
		    }
		}
	}

