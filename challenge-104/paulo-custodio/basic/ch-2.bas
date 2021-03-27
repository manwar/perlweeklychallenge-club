' Challenge 104
'
' TASK #2 › NIM Game
' Submitted by: Mohammad S Anwar
' Write a script to simulate the NIM Game.
'
' It is played between 2 players. For the purpose of this task, let assume you
' play against the machine.
'
' There are 3 simple rules to follow:
'
' a) You have 12 tokens
' b) Each player can pick 1, 2 or 3 tokens at a time
' c) The player who picks the last token wins the game
'
' A plays to win, B plays randomly, A wins 91% of the time
' If both play to win, the second player to play always wins

const matches as integer = 100000

function play_to_win(T as integer) as integer
    if T <= 3 then
        play_to_win=T
    elseif (T mod 4)=0 then
        play_to_win=1
    elseif (T mod 5)=0 then
        play_to_win=1
    elseif (T mod 6)=0 then
        play_to_win=2
    elseif (T mod 7)=0 then
        play_to_win=3
    elseif (T mod 9)=0 then
        play_to_win=2
    elseif (T mod 11)=0 then
        play_to_win=2
    else
        error 1
    end if
end function

function rand_play(T as integer) as integer
    return int(rnd*3)+1
end function

sub play(is_rand as boolean)
    dim winsA as integer, winsB as integer, i as integer, T as integer, move as integer

    for i=1 to matches
        T = 12
        do while T > 0
            ' player A
            move = play_to_win(T)
            T = T - move
            if T <= 0 then
                winsA = winsA+1
                exit do
            end if
            ' player B
            if is_rand then
                move = rand_play(T)
            else
                move = play_to_win(T)
            end if
            T = T - move
            if T <= 0 then
                winsB = winsB+1
                exit do
            end if
        loop
    next

    print "A wins ";int((winsA)/(winsA+winsB)*100);"% of the matches."
end sub

if command(1)="random" then
    play true
else
    play false
end if
