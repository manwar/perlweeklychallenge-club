#!/usr/bin/perl
use Modern::Perl;

# Write a script to accept a string from command
# line and split it on change of character.
# For example, if the string is “ABBCDEEF”, then it
# should split like “A”, “BB”, “C”, “D”, “EE”, “F”.

my $str = shift || "ABBCDEEF";
my @str = split(//,$str);

my ($a, $b) = splice(@str,0,2);
my $out = $a;
while (defined($b)) {
    if ($a eq $b) {
    	$out .= $b;
    } else {
    	print "$out,";
    	$out = $b;
    }
    $a = $b;
    $b = shift(@str);
}
say $out;

__END__

./ch-1.pl
A,BB,C,D,EE,F

./ch-1.pl "hello world"
h,e,ll,o, ,w,o,r,l,d

./ch-1.pl "Nowww is the tttime for all gooood mmmeeennn"
N,o,www, ,i,s, ,t,h,e, ,ttt,i,m,e, ,f,o,r, ,a,ll, ,g,oooo,d, ,mmm,eee,nnn

./ch-1.pl 3104630088
3,1,0,4,6,3,00,88

