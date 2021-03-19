#! /usr/bin/env gforth

\ Challenge 103
\
\ TASK #1 › Chinese Zodiac
\ Submitted by: Mohammad S Anwar
\ You are given a year $year.
\
\ Write a script to determine the Chinese Zodiac for the given year $year.
\ Please check out wikipage for more information about it.
\
\ The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
\ Rooster, Dog, Pig.
\ The element cycle: Wood, Fire, Earth, Metal, Water.
\
\ Example 1:
\     Input: 2017
\     Output: Fire Rooster
\ Example 2:
\     Input: 1938
\     Output: Earth Tiger

: .one  { addr len n -- , type name }
    addr
    n 8 * +                 \ start of word
    8 -TRAILING TYPE SPACE ;

: .animal   { n -- , prints name of animal }
    S" Rat     Ox      Tiger   Rabbit  Dragon  Snake   Horse   Goat    Monkey  Rooster Dog     Pig     "
    n 12 MOD .one ;

: .element   { n -- , prints name of element }
    S" Wood    Wood    Fire    Fire    Earth   Earth   Metal   Metal   Water   Water   "
    n 10 MOD .one ;


NEXT-ARG S>NUMBER? 0= THROW DROP    \ get year
1924 -                              \ subtract base year
DUP .element .animal CR
BYE
