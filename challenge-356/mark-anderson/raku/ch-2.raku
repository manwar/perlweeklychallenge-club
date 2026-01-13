#!/usr/bin/env raku
use JSON::Fast;
use Test;
plan 64;
    
grammar Who-Wins
{
    token TOP        { <week-one> <week-two> <week-three> }
    token week-one   { <AH> ** 3                          }
    token week-two   { <AH> ** 2                          }
    token week-three { <AH>                               }
    token AH         { A|H                                }
}

class actions
{
    my $week-two;
    my $week-three;

    method week-one($/) 
    { 
        my %week-one :=
        {
            AAA => < 5 6 7 >,  
            AAH => < 4 6 7 >,  
            AHA => < 3 5 7 >,  
            AHH => < 3 4 7 >,  
            HAA => < 2 5 6 >,  
            HAH => < 2 4 6 >,  
            HHA => < 2 3 5 >, 
            HHH => < 2 3 4 > 
        }

        $week-two = %week-one{$/}
    }

    method week-two($/)
    {
        my %week-two := 
        {
            AA => [ $week-two[1], $week-two[2] ], 
            AH => [ $week-two[0], $week-two[2] ], 
            HA => [ 1           , $week-two[1] ], 
            HH => [ 1           , $week-two[0] ]  
        }

        $week-three = %week-two{$/}
    }

    method week-three($/)
    {
        my %week-three :=
        {
            A => $week-three[1],
            H => $week-three[0]
        }

        make "%week-three{$/} defeated {$week-three (-) %week-three{$/}}"
    }
}

my %h = from-json $=finish;

for %h.keys.sort -> $k
{
    is who-wins($k), %h{$k}, "$k => %h{$k}"
}

sub who-wins($str)
{
    Who-Wins.parse($str, :actions(actions))<week-three>.made
}

=finish
{
    "AAAAAA": "7 defeated 6",    "AAAAAH": "6 defeated 7",
    "AAAAHA": "7 defeated 5",    "AAAAHH": "5 defeated 7",
    "AAAHAA": "6 defeated 1",    "AAAHAH": "1 defeated 6",
    "AAAHHA": "5 defeated 1",    "AAAHHH": "1 defeated 5",
    "AAHAAA": "7 defeated 6",    "AAHAAH": "6 defeated 7",
    "AAHAHA": "7 defeated 4",    "AAHAHH": "4 defeated 7",
    "AAHHAA": "6 defeated 1",    "AAHHAH": "1 defeated 6",
    "AAHHHA": "4 defeated 1",    "AAHHHH": "1 defeated 4",
    "AHAAAA": "7 defeated 5",    "AHAAAH": "5 defeated 7",
    "AHAAHA": "7 defeated 3",    "AHAAHH": "3 defeated 7",
    "AHAHAA": "5 defeated 1",    "AHAHAH": "1 defeated 5",
    "AHAHHA": "3 defeated 1",    "AHAHHH": "1 defeated 3",
    "AHHAAA": "7 defeated 4",    "AHHAAH": "4 defeated 7",
    "AHHAHA": "7 defeated 3",    "AHHAHH": "3 defeated 7",
    "AHHHAA": "4 defeated 1",    "AHHHAH": "1 defeated 4",
    "AHHHHA": "3 defeated 1",    "AHHHHH": "1 defeated 3",
    "HAAAAA": "6 defeated 5",    "HAAAAH": "5 defeated 6",
    "HAAAHA": "6 defeated 2",    "HAAAHH": "2 defeated 6",
    "HAAHAA": "5 defeated 1",    "HAAHAH": "1 defeated 5",
    "HAAHHA": "2 defeated 1",    "HAAHHH": "1 defeated 2",
    "HAHAAA": "6 defeated 4",    "HAHAAH": "4 defeated 6",
    "HAHAHA": "6 defeated 2",    "HAHAHH": "2 defeated 6",
    "HAHHAA": "4 defeated 1",    "HAHHAH": "1 defeated 4",
    "HAHHHA": "2 defeated 1",    "HAHHHH": "1 defeated 2",
    "HHAAAA": "5 defeated 3",    "HHAAAH": "3 defeated 5",
    "HHAAHA": "5 defeated 2",    "HHAAHH": "2 defeated 5",
    "HHAHAA": "3 defeated 1",    "HHAHAH": "1 defeated 3",
    "HHAHHA": "2 defeated 1",    "HHAHHH": "1 defeated 2",
    "HHHAAA": "4 defeated 3",    "HHHAAH": "3 defeated 4",
    "HHHAHA": "4 defeated 2",    "HHHAHH": "2 defeated 4",
    "HHHHAA": "3 defeated 1",    "HHHHAH": "1 defeated 3",
    "HHHHHA": "2 defeated 1",    "HHHHHH": "1 defeated 2"
}
