#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @choices = ( \&chose_paper, \&chose_scissors, \&chose_rock );

my @outcomes = (
    [   \&draw,             \&scissors_loss,    \&paper_win,    ],
    [   \&scissors_win,     \&draw,             \&rock_loss,    ],
    [   \&paper_loss,       \&rock_win,         \&draw,         ]
);   

my @winners = ( \&winner_A, \&winner_B );

sub chose_paper {
    my ($chooser) = @_;

    say "$chooser chose Paper.";
}

sub chose_scissors {
    my ($chooser) = @_;

    say "$chooser chose Scissors.";
}

sub chose_rock {
    my ($chooser) = @_;

    say "$chooser chose Rock.";
}

sub paper_win {
    say "Paper covers Rock.  ";
    &{$winners[0]};
}

sub paper_loss {
    say "Paper covers Rock.  ";
    &{$winners[1]};
}

sub scissors_win {
    say "Scissors cuts Paper.  ";
    &{$winners[0]};
}

sub scissors_loss {
    say "Scissors cuts Paper.  ";
    &{$winners[1]};
}

sub rock_win {
    say "Rock smashes Scissors.  ";
    &{$winners[0]};
}

sub rock_loss {
    say "Rock smashes Scissors.  ";
    &{$winners[1]};
}

sub draw {
    say "It's a draw.";
}

sub winner_A {
    say "A wins.";
}

sub winner_B {
    say "B wins.";
}

my $achoice = int rand 3;
my $bchoice = int rand 3;

$choices[$achoice]('A');
$choices[$bchoice]('B');

$outcomes[$achoice][$bchoice]();
