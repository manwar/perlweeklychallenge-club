#!/usr/bin/env raku

# with help from
# https://www.futurelearn.com/info/courses/recreational-math/0/steps/43529

role machine-play
{
    method play($heap)
    {
        $heap mod 4 || (1..min(3, $heap)).pick; 
    }
}

role human-play
{
    method play($heap)
    {
        my $tokens = 0;

        while $tokens !~~ 1..min(3, $heap) 
        {
            $tokens = prompt("How many: ");
        }

        $tokens;
    }
}

class player
{
    has $.name;
}

class nim
{
    has @.players;
    has $.heap is rw;
    has $!tokens;

    method play
    {
        say @.players.head.name ~ " chooses first\n";

        loop 
        {
            last unless $.heap;
            say "heap = $.heap\n";
            $!tokens = @.players.head.play($.heap);
            say @.players.head.name ~ " chose $!tokens\n";
            $.heap -= $!tokens;
            @.players .= rotate(1);
        }
        
        say @.players.tail.name ~ " is the winner";
    }

    submethod TWEAK 
    {
        self.players .= rotate(<0 1>.pick);
    }
}

my $h = player.new(name => "Human")   but human-play;
my $m = player.new(name => "Machine") but machine-play;
my $nim = nim.new(heap => 12, players => [$h, $m]);

$nim.play;
