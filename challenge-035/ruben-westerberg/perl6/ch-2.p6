#!/usr/bin/env perl6

my %forwardTable=map { (.key=> join("0",comb "",.value))}, (
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
%reverseTable{%forwardTable{$_}}=$_ for (keys %forwardTable);

my $string= @*ARGS[0]//"abc";
$string~~tr/A..Z/a..z/;

print "Original String: $string\n";

my $e=encode($string);
print "Encoded: $e\n";

my $packed=packbitstring($e);

my $unpacked=unpackbitstring($packed);

put "Unpacked: $unpacked";

my $d=decode($unpacked);
put "Decoded: $d";

sub encode ($in) {
	
	my @codes=map { |($_,"000") },  %forwardTable{$in.comb("")};
	@codes.pop;
	my $out="";
	for (map { |(comb "", $_)}, @codes) {
		when /\./ {
			$out~="1";
		}
		when /\-/ {
			$out~="111";
		}
		when /0/ {
			$out~="0";
		}
		default {
		}
	}
	$out;
}

sub decode($in) {

	my $out="";
	for (split "000", $in) {
		when (/^$/) {
			$out~=" ";
		}
		default {
			my $a=S:g/111/-/;
			$a~~s:g/1/./;
			my $c=%reverseTable{$a};

			while (! $c ) {  #fix extra bits at end of byte
				$a=substr($a,0,chars($a) -1);
				$c=%reverseTable{$a};
			}
			$out~=$c;
		}
	}
	$out;
}
 sub packbitstring($in) {
	 my uint8 $byte=0;
	 my Buf $out.=new;
	 for ($in.comb) {
		 state $i=0;
		 $byte+|= $_.Int +< (7-$i++);
		 if $i %% 8  {
			 $i=0;
			 $out.append: $byte;
			 $byte=0;
		 }
		 LAST {
			 $out.append: $byte if $byte;
		 }
	 }
	 $out;
 }
		 
sub unpackbitstring($in) {
	my @bits;
	for $in[] {
		my $byte=$_;
		for 0..7 {
			@bits.push: ($byte +< $_ +& 0x80)??"1"!!"0";
		}
	}
	@bits.join;
}

