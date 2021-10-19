#!perl ch-2.pl $m $n

use strict;
my ($m, $n)= @ARGV;
my $w = length($m*$n)+1;
print 'x | 1';
printf ("% ${w}d", $_) foreach (2..$n);
print "\n";
print '--+--';
print ('-'x$w) foreach (2..$n);
print "\n";
my %h;
foreach my $i (1..$m)
    {
    $h{$i} = undef;
    print "$i | $i";
    foreach my $j (2..$n)
    	{
    	$h{$i*$j} = undef;
    	printf "% ${w}d", $i*$j;
    	}
    print "\n";
    }
print 'Distinct Terms: ';
foreach (sort { $a <=> $b }  keys %h)
    {
    print $_, ', ';
    }
print "\b\b \nCount: ", scalar(keys %h);
