#!/usr/bin/env perl
use strict;
use warnings;
use experimental qw<switch>;
use v5.26;

my %forwardTable=map { join "0",split "",$_}(
	a=>".-",
	b=>"-...",
	c=>"-.-.",
	d=>"-..",
	e=>".",
	f=>"..-.",
	g=>"--.",
	h=>"....",
	i=>"..",
	j=>".---",
	k=>"-.-",
	l=>".-...",
	n=>"-.",
	m=>"--",
	o=>"---",
	p=>".--.",
	q=>"--.-",
	r=>".-.",
	s=>"...",
	t=>"-",
	u=>"..-",
	v=>"...-",
	w=>".--",
	x=>"-..-",
	y=>"-.--",
	z=>"--..",
	1=>".----",
	2=>"..---",
	3=>"...--",
	4=>"....-",
	5=>".....",
	6=>"-....",
	7=>"--...",
	8=>"---..",
	9=>"----.",
	0=>"-----",
	" "=>""
);

my %reverseTable;
$reverseTable{$forwardTable{$_}}=$_ for (keys %forwardTable);

my $string= $ARGV[0]//"abc";
$string=~tr/A-Z/a-z/;

print "Original String: $string\n";

my $e=encode($string);
print "Encoded: $e\n";

my $packed=pack("B*",$e);

my $unpacked=unpack("B*",$packed);
print "Unpacked: ".$unpacked."\n";

my $d=decode($unpacked);
print "Decoded: $d\n";

#===
sub encode {
	my ($in)=@_;
	my @codes= map { ($_,"000") }  @forwardTable{split "", $in};
	pop @codes;	#Remove last charater gap
	my $out="";
	for (map { split "", $_}@codes) {
		when (/\./) {
			$out.="1";
		}
		when (/-/) {
			$out.="111";
		}
		when (/0/) {
			$out.="0";
		}
		default {
		}
	}
	$out;
}

sub decode {

	my ($in)=@_;
	my $out="";
	for (split "000", $in) {
		when (/^$/) {
			$out.=" ";
		}
		default {
			s/111/-/g;
			s/1/./g;
			#	s/0//g;
			my $c=$reverseTable{$_};

			while (! $c ){  #fix extra bits at end of byte
				$_=substr($_,0,length($_) -1);
				$c=$reverseTable{$_};
			}
			$out.=$c;
		}
	}
	$out;
}
