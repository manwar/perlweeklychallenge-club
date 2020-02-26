#!/usr/bin/perl
use strict;
use integer;

my $i = 0;

my $msg;

chomp($msg = <STDIN>);

$msg = lc($msg);

$msg =~ s/\s//g; # &removespace($_);
$msg =~ s/\t//g;

# print $msg, "\n"; #TESTING

my $i = 0;

my $j = 0;

my @a;

#ADD WHITESPACE AT THE END SUCH THAT THE LINE HAS 8n CHARACTERS
my $copyoflengthofmsg = length($msg);
$msg .= " " x ($copyoflengthofmsg % 8);

my $numberofcols = 8;

foreach my $char (split //, $msg) {                       #Thanks Perl Cookboo
	$a[$i][$j] = $char;
        $copyoflengthofmsg++;
	$j++;
	if ($j==$numberofcols) {$j = 0; $i++;}
}

my @b;
my $p;


#TESTING
#for $i (0..7) {
#	for $j (0..$numberofcols) {
#		$b[$p] = $a[$i][$j];
#		print $b[$p]; 
#		$p++;
#	}
#	print "\n"; #print " ";
#}
#print "---\n";


$p = 0;
for $j (0..$numberofcols) {
	for $i (0..7) {
		$b[$p] = $a[$i][$j];
		if ($b[$p] ne " ") {print $b[$p];}
		$p++;
	}
	print " ";
}


