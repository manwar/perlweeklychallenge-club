use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

        raku ch-2.raku --name=Larry --first

    If no --first argument is given, the computer makes the first move.

=end comment
#==============================================================================

my UInt constant TOKENS-AT-START = 12;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 104, Task #2: NIM Game (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D  :$name where { 0 < $name.chars <= 8 },  #= Player's name (1-8 chars)
    Bool:D :$first = False                         #= Human player moves first?
)
#==============================================================================
{
    "Hello %s, welcome to NIM. You have chosen to move %s.\n\n".printf:
        $name, $first ?? 'first' !! 'second';

    my UInt $move      = 0;
    my UInt $tokens    = TOKENS-AT-START;
    my Bool $user-wins = True;

    "%d.                   Tokens at start:  %2d\n".printf: $move, $tokens;

    human-move( ++$move, $tokens, $name ) if $first;

    until $tokens == 0
    {
        computer-move( ++$move, $tokens );

        if $tokens > 0
        {
            human-move( ++$move, $tokens, $name );
        }
        else
        {
            $user-wins = False;
        }
    }

    "\nGame over: %s wins!\n".printf: $user-wins ?? $name !! 'Computer';
}

#------------------------------------------------------------------------------
sub human-move( UInt:D $move, UInt:D $tokens is rw, Str:D $name )
#------------------------------------------------------------------------------
{
    my UInt @choices = $tokens >= 3 ?? (1, 2, 3) !!
                       $tokens == 2 ?? (1, 2)    !! 1;
    my Bool $done    = False;

    until $done
    {
        '   Enter your pick (%s): '.printf: @choices.join: ', ';

        my Str $entry = $*IN.get;

        if +$entry ~~ UInt
        {
            my UInt $pick = +$entry;

            if 0 < $pick <= @choices[ *-1 ]
            {
                $tokens -= $pick;

                "%d. %-8s picks %d. Tokens remaining: %2d\n".printf:
                    $move, $name, $pick, $tokens;

                $done = True;
            }
        }

        '   * Invalid entry, try again.'.put unless $done;
    }
}

#------------------------------------------------------------------------------
sub computer-move( UInt:D $move, UInt:D $tokens is rw )
#------------------------------------------------------------------------------
{
    my UInt $pick = ($tokens % 4 == 0) ?? ((^3).pick + 1) !! ($tokens % 4);

    $pick    = $tokens if $pick > $tokens;
    $tokens -= $pick;

    "%d. Computer picks %d. Tokens remaining: %2d\n".printf:
        $move, $pick, $tokens;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
