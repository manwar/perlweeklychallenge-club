#!/usr/bin/env perl6

# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell?
# Here is the list of U.S. states abbreviations as per wikipedia page.
# This challenge was proposed by team member Neil Bowers.

use v6.c;

use WWW;

our $online-wordlist = 'https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt';
our $local-wordlist = '/usr/share/dict/words';

sub get-words() {
	sub get-local-words($path) {
		$path.IO.e ?? $path.IO.lines>>.trim !! Nil
	}
	get-local-words($local-wordlist) // get-local-words('words') // 
		get($online-wordlist).words;
}
sub get-states(:$territories) {
	my $states = <
		AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS
		MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV
		WI WY>;
	my $others = <DC AS GU MP PR VI FM MH PW AA AE AP CM CZ NB PI TT>;
	|$states, |($territories ?? $others !! ());
}

proto MAIN(|) {*}
multi MAIN(Bool :$test!) {
	use Test;
	my @states = get-states;
	cmp-ok 'code', '~~', /:i^@states$/, "Pattern match a word";
}
multi MAIN(Bool :$territories) {
	my @wordlist = get-words.grep({.defined});
	my @states = get-states(:$territories);
	say @wordlist.grep(/:i^@states+$/).max(*.chars);
}