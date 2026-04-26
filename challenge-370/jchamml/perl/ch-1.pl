$paragraph = "Bob hit a ball, the hit BALL flew far after it was hit.";
@banned = ("hit");

$paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange.";
@banned = ("apple", "pear");

$paragraph = "A. a, a! A. B. b. b.";
@banned = ("b");

$paragraph = "Ball.ball,ball:apple!apple.banana";
@banned = ("ball");

$paragraph = "The dog chased the cat, but the dog was faster than the cat.";
@banned = ("the", "dog");

my %isBanned = ();
for (@banned) { $isBanned{$_} = 1;}

@words = split(/\W+/,lc($paragraph));
foreach $word (@words) {
   next if ($isBanned{$word});
   $frequency{$word}++;
   }

my $popWord = "";
foreach $word (keys(%frequency)) {
    if ($frequency{$word} > $frequency{$popWord}) {
        $popWord = $word;
    }
}
print "The most popular non-banned word is \"$popWord\" with $frequency{$popWord} occurrances\n";
