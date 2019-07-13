#!/usr/bin/env perl6
use Digest::SHA;
#
my @addresses=@*ARGS;
@addresses= qw<1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
	3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy> unless @addresses;

my %b;
my @valid=("1".."9","A".."H","J".."N","P".."Z","a".."k","m".."z").flat;
%b{$_}=$++ for @valid;

for (@addresses) {
	print "Testing Address: $_\n";
	unless so all(comb("",$_)) eq any(@valid) { print  "Invalid characters found: $_\n"; next}
	my Int $sum=0;				#Int type grows as needed
	my @a=reverse (comb("", $_));
	for @a.kv  {
		$sum+=%b{$^v} *(58**$^k);
	}
	my $buff=Buf.new($sum.base(16).fmt("%050s").comb(2)>>.fmt("%02s")>>.parse-base(16));
	unless ($buff.elems <= 25) { print  "Invalid length: $_\n"; next }

	$buff.unshift(0) while ($buff.elems < 25);
	my $check= sha256(sha256($buff.subbuf(0,21))).subbuf(0,4);
	my $inCheck=$buff.subbuf(21,4);
	unless ($check eq $inCheck) { print "Check sum mismatch: $_\n"; next};
	print "Address OK: $_\n\n";

}
