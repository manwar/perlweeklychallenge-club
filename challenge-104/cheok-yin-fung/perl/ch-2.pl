#!/usr/bin/perl
# The Weekly Challenge 104
# NIM Game
use strict;
use warnings;

my $remain = 12;

my $player = int rand(2);

print "                    NIM Game\n    ";
print " |" x 12, "\n";

#from task statment

print 
'For the purpose of this task, let assume you play against the machine.

There are 3 simple rules to follow:

a) You have 12 tokens
b) Each player can pick 1, 2 or 3 tokens at a time
c) The player who picks the last token wins the game


For simplicity, we have already randomly assigned the player:
';

if ($player == 1) {
    print " First Player: YOU;\nSecond Player: COMPUTER;\n";
    your_decision();
}
else
{
    print " First Player: COMPUTER;\nSecond Player: YOU;\n";
    machine_decision();
}

# =========================================================
# ================ Subroutines ============================
# =========================================================


sub machine_decision {
    my $m_take;
    if ($remain % 4 != 0) {
        $m_take = $remain % 4;
    }
    else {
        $m_take = 1 + int rand(3);
    }
    print "The computer decides to take $m_take token";
    print ($m_take == 1 ? "." : "s." );
    print "\n";
    pick($m_take, ($player+1) % 2);
}

sub your_decision {
    print "Please input how many tokens you want to take: ";
    my $inpt = <STDIN>;
    chomp($inpt);
    if (($inpt >= 4 or $inpt <= 0) || ($remain < $inpt)) {
        print "WARN: invalid input; Please input again\n"; 
        your_decision();
    }
    else {
        pick(int $inpt, $player);
    }
}

sub pick {
    my $num = $_[0];
    my $side = $_[1];
    $remain -= $num;
    die "Invalid operation!" if $remain < 0 || $num >= 4 || $num <= 0 ;

    if ($remain == 0) {
        endgame($side);
    }

    print "\n    ", "| "  x $remain;
    print "\nNumber of tokens remain: $remain\n";
    
    if ($side == $player) {
        machine_decision();
    }
    else {
        your_decision();
    }

}

sub endgame {
    my $winner = $_[0];
    print "The winner is ";
    if ($winner == $player) {
        print "YOU. \n"
    } 
    else {
        print "the computer. \n" 
    }
    print "Good game. \n";
    exit;
}
