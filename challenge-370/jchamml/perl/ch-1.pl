use strict;
use warnings;

my $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.";
my @banned = ("hit");
my ($word,$freq) = popword($paragraph,@banned);


$paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange.";
@banned = ("apple", "pear");
($word,$freq) = popword($paragraph,@banned);

$paragraph = "A. a, a! A. B. b. b.";
@banned = ("b");
($word,$freq) = popword($paragraph,@banned);

$paragraph = "Ball.ball,ball:apple!apple.banana";
@banned = ("ball");
($word,$freq) = popword($paragraph,@banned);

$paragraph = "The dog chased the cat, but the dog was faster than the cat.";
@banned = ("the", "dog");
($word,$freq) = popword($paragraph,@banned);

sub popword {
    my $paragraph = $_[0];
    my @banned = $_[1];
    print "paragraph:$paragraph\n";
    print "banned: @banned\n";

    my %isBanned = ();
    my %frequency = ();
    for (@banned) { $isBanned{$_} = 1;} #Put banned word in a hash so we can test for them when counting

    my @words = split(/\W+/,lc($paragraph));  #Put words, without non word characters, into array @words
    foreach $word (@words) {               #Iterate over words
        next if ($isBanned{$word});        #skipping banned words
        $frequency{$word}++;               #Count them in the hash 
    }

    my $pWord = "";
    $frequency{""}=0;
    foreach my $word (keys(%frequency)) {     #iterate over count hash
        if ($frequency{$word} > $frequency{$pWord}) { #looking for largest
            $pWord = $word;              #saving it for output
        } 
    }  
    print "The most popular non-banned word is \"$pWord\" with $frequency{$pWord} occurrances\n\n";
    return ($pWord,$frequency{$pWord});
}
