#!perl

###############################################################################
=comment

Perl Weekly Challenge 104
=========================

Task #2
-------
*NIM Game*

Submitted by: Mohammad S Anwar

Write a script to simulate the NIM Game.

It is played between 2 players. For the purpose of this task, let assume you
play against the machine.

There are 3 simple rules to follow:

 a) You have 12 tokens
 b) Each player can pick 1, 2 or 3 tokens at a time
 c) The player who picks the last token wins the game

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

1.  Strategy
    --------
    All multiples of 4 tokens are losing positions, because whatever pick is
    made, the following player can pick so as to reduce the tokens to another
    multiple of 4. Hence, the player moving second can always force a win.

    When the computer is in a losing position, it picks randomly.

2.  Game play
    ---------
    The human player's name and (optionally) choice to move first are entered
    on the command line:

        perl ch-2.pl --name Larry --first

    If no --first argument is given, the computer makes the first move.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $TOKENS_AT_START => 12;
const my $USAGE =>
"Usage:
  perl $0 [--name=<Str>] [--first]

    --name=<Str>    Player's name (1-8 chars)
    --first         Human player moves first?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 104, Task #2: NIM Game (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($name, $first) = parse_command_line();

    printf "Hello %s, welcome to NIM. You have chosen to move %s.\n\n",
            $name, $first ? 'first' : 'second';

    my $move      = 0;
    my $tokens    = $TOKENS_AT_START;
    my $user_wins = 1;

    printf "%d.                   Tokens at start:  %2d\n", $move, $tokens;

    human_move( ++$move, \$tokens, $name ) if $first;

    until ($tokens == 0)
    {
        computer_move( ++$move, \$tokens );

        if ($tokens > 0)
        {
            human_move( ++$move, \$tokens, $name );
        }
        else
        {
            $user_wins = 0;
        }
    }

    printf "\nGame over: %s wins!\n", $user_wins ? $name : 'Computer';
}

#------------------------------------------------------------------------------
sub human_move
#------------------------------------------------------------------------------
{
    my ($move, $tokens, $name) = @_;
    my  @choices = $$tokens >= 3 ? (1, 2, 3) :
                   $$tokens == 2 ? (1, 2)    : 1;
    my  $done    = 0;

    until ($done)
    {
        printf '   Enter your pick (%s): ', join ', ', @choices;

        my $pick = <STDIN>;

        if ($pick =~ / ^ $RE{num}{int} $ /x && 0 < $pick <= $choices[ -1 ])
        {
            $$tokens -= $pick;

            printf "%d. %-8s picks %d. Tokens remaining: %2d\n",
                $move, $name, $pick, $$tokens;

            $done = 1;
        }

        print "   * Invalid entry, try again.\n" unless $done;
    }
}

#------------------------------------------------------------------------------
sub computer_move
#------------------------------------------------------------------------------
{
    my ($move, $tokens) = @_;
    my  $pick     = ($$tokens % 4 == 0) ? (int( rand 3 ) + 1) : ($$tokens % 4);
        $pick     =  $$tokens if $pick > $$tokens;
        $$tokens -=  $pick;

    printf "%d. Computer picks %d. Tokens remaining: %2d\n",
            $move, $pick, $$tokens;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $name  = '';
    my $first =  0;

    GetOptions
    (
        'name=s' => \$name,
        'first'  => \$first,

    ) or error( "Error in command line arguments\n" );

    if    (length $name == 0)
    {
         error( 'Name missing' );
    }
    elsif (length $name >  8)
    {
         error( 'Name too long' );
    }

    return ($name, $first);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
