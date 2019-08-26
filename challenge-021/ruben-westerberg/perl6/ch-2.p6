#!/usr/bin/env perl6

my $URI=@*ARGS[0]//'HTTP://a.uri/with/strange%65characters{}?query=true#frag<>';

print "Original URI:\t$URI\n";
#%Encode any character outside of restriced and unrestricted set except %
$URI=S:g/(<-[0..9a..zA..Z\-_.~\%\!\*\'\(\)\;\:\@\&\=\+\$\,\/\?\#\[\]]>)/{sprintf("%%%2X",ord $0.Str)}/ given $URI;

#Normalize decode any encoded unresreved characters. Normalize encoding to upper case
$URI=S:g/\%(<[a..fA..F0..9]>**2)/{decode($0)}/ given $URI;
sub decode ($h){
	my $c=chr :16($h.Str);
	/<[0..9a..zA..Z\-_.~]>/ ?? $c!!uc "%$h" given $c;
	#"AAA";
}

#Scheme to lower case
$URI=S/^(<[a..zA..Z]><[a..zA..Z\-\.\+]>+)/{lc $0}/ given $URI;

print "Normalized URI:\t$URI\n";
