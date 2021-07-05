#! /usr/bin/env gforth

\ Challenge 120
\
\ TASK #2 › Clock Angle
\ Submitted by: Mohammad S Anwar
\ You are given time $T in the format hh:mm.
\
\ Write a script to find the smaller angle formed by the hands of an analog
\ clock at a given time.
\
\ HINT: A analog clock is divided up into 12 sectors. One sector represents 30
\ degree (360/12 = 30).
\
\ Example
\ Input: $T = '03:10'
\ Output: 35 degree
\
\ The distance between the 2 and the 3 on the clock is 30 degree.
\ For the 10 minutes i.e. 1/6 of an hour that have passed.
\ The hour hand has also moved 1/6 of the distance between the 3 and the 4,
\ which adds 5 degree (1/6 of 30).
\ The total measure of the angle is 35 degree.
\
\ Input: $T = '04:00'
\ Output: 120 degree

: parse_time    ( addr len -- hh mm )
    0. 2SWAP                ( 0  0 addr len )
    >NUMBER                 ( hh 0 addr len )   \ convert hh
    1 /STRING                                   \ skip ':'
    0 -ROT                  ( hh 0 0 addr len )
    >NUMBER                 ( hh mm 0 addr len )
    2DROP DROP ;

: clock_angle   { hh mm -- angle }
    mm 360 60 */                            { mm_angle }
    hh 12 MOD 360 12 */  mm_angle 12 /  +   { hh_angle }
    hh_angle mm_angle - ABS                 ( angle )
    DUP 180 > IF 360 SWAP - THEN ;

NEXT-ARG parse_time clock_angle . CR BYE

\ #include <stdio.h>
\ #include <stdlib.h>
\ #include <stdbool.h>
\
\
\ int clock_angle(int hh, int mm) {
\   int mm_angle = mm*360/60;
\   int hh_angle = (hh % 12)*360/12 + mm_angle/12;
\     int angle = abs(hh_angle - mm_angle);
\     if (angle > 180) { angle = 360 - angle; }
\     return angle;
\ }
\
\ int main(int argc, char* argv[]) {
\     if (argc != 2) return EXIT_FAILURE;
\     int hh, mm;
\     if (!parse_time(argv[1], &hh, &mm)) return EXIT_FAILURE;
\     int angle = clock_angle(hh, mm);
\     printf("%d\n", angle);
\ }
\
