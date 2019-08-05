#!/usr/bin/perl
use Modern::Perl;

#https://perlweeklychallenge.org/blog/perl-weekly-challenge-015/
#Write a script to implement Vigenère cipher. The script should be able encode and decode. 
#Checkout wiki page https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher for more information.
#
#Make it easy for the next coder to modify, just translate the wiki formula into perl
#encryption
#Ci = Mi + Ki mod 26
#decryption
#Mi = Ci - Ki mod 26

my $text = shift || "ATTACKATDAWN";
my $key = shift  || "LEMON";
my $encrypt = shift;
$encrypt = (defined $encrypt) ? -1 : 1; #default to encrypt mode

my @m = split(//,$text);
my @k = split(//,$key);
my $OFFSET = 65; #offset index by 65, the ASCII value of A, in effect creating the tabula recta

my $out;
my $i = 0;
foreach my $m (@m) {
	my $k = $k[$i];
	$i = ($i < @k-1) ? $i+1 : 0; #repeat key chars if key is shorter than the input text
	my $c = (unpack("C*",$m) + $encrypt * unpack("C*",$k)) % 26; #we add if encrypt, subtract if decrypt
	$out .= pack("C*", $c+$OFFSET) ;
}
say $out;

__END__

./ch2.pl ATTACKATDAWN LEMON 
LXFOPVEFRNHR
./ch2.pl LXFOPVEFRNHR LEMON 1
ATTACKATDAWN

./ch2.pl THESECRETCODISHELLOWORLD PASSPHRASEISPERLRULESTHEDAY 
IHWKTJIELGWVXWYPCFZAGKSH
./ch2.pl IHWKTJIELGWVXWYPCFZAGKSH PASSPHRASEISPERLRULESTHEDAY 1
THESECRETCODISHELLOWORLD

