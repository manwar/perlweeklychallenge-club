#!/usr/bin/env raku

# with help from
# https://www.futurelearn.com/info/courses/recreational-math/0/steps/43529

my @players = (<Human Machine>, <Machine Human>)[<0 1>.pick];
   @players = flat @players xx 6;

say "{@players.head} chooses first\n";

my $heap = 12;

loop 
{
    last unless $heap;

    say "heap = $heap\n";

    my $player = shift @players;

    my $tokens = choose($player);

    say "$player chose $tokens\n";

    $heap -= $tokens;
}

multi choose(\player where * eq "Machine")
{
    $heap mod 4 || 1;
}

multi choose(\player where * eq "Human")
{
    my $tokens = 0;
                                
    while $tokens !~~ 1..min(3, $heap) 
    {
        $tokens = prompt("How many: ");
    }

    $tokens;
}
