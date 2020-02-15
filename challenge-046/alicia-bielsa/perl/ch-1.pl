
use strict;
use warnings;
use Data::Dumper;

#Cryptic Message
#The communication system of an office is broken and message received are not completely reliable. To send message Hello, it ended up sending these following:
#
#H x l 4 !
#c e - l o
#z e 6 l g
#H W l v R
#q 9 m # o
#Similary another day we received a message repeatedly like below:
#
#P + 2 l ! a t o
#1 e 8 0 R $ 4 u
#5 - r ] + a > /
#P x w l b 3 k \
#2 e 3 5 R 8 y u
#< ! r ^ ( ) k 0
#Write a script to decrypt the above repeated message (one message repeated 6 times).
#
#HINT: Look for characters repeated in a particular position in all six messages received.

my @aMessage1 = qw(P + 2 l ! a t o);
my @aMessage2 = qw(1 e 8 0 R $ 4 u);
my @aMessage3 = qw(5 - r ] + a > /);
my @aMessage4 = qw(P x w l b 3 k \\);
my @aMessage5 = qw(2 e 3 5 R 8 y u);
my @aMessage6 = qw(< ! r ^ ( ) k 0);
my @aCharactersRepeated = ();
my $lengthMessage = scalar(@aMessage1);
my @aAllMessages = (@aMessage1, @aMessage2 ,@aMessage3, @aMessage4, @aMessage5 ,@aMessage6);
my %hCharacters = ();

foreach my $indexAllMesages (0..$#aAllMessages){
    my $indexMessage =  $indexAllMesages % $lengthMessage;
    my $currentCharacter = $aAllMessages[$indexAllMesages];
    unless (exists($hCharacters{$indexMessage})){
        $hCharacters{$indexMessage} =();
    }    
    unless (exists($hCharacters{$indexMessage}{$currentCharacter})){
        $hCharacters{$indexMessage}{$currentCharacter} = 0 ;
    }
    $hCharacters{$indexMessage}{$currentCharacter} ++;
    if ($hCharacters{$indexMessage}{$currentCharacter} == 2 ){
        $aCharactersRepeated[$indexMessage] = $currentCharacter;
    }
}
print "Decrypted Message:";
foreach my $character (@aCharactersRepeated){
    print "$character";
}
print "\n";
