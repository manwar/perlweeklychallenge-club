0100 REM 
0101 REM  See ../README.md
0102 REM 

0200 REM 
0201 REM  Run as: basic.pl ch-2.bas
0202 REM 

1000 LET tokens  = 12
1010 LET maxtake =  3

1100 REM 
1101 REM  Print the prompt
1102 REM 

1110 PRINT "How many tokens do you take? (";
1120 IF tokens < 10 THEN PRINT " ";
1130 PRINT tokens;
1140 PRINT "tokens are left) ";


1200 REM 
1201 REM  Read input and validate. Not going to work well if
1202 REM  anything non-numeric is given as input.
1203 REM 

1210 INPUT ""; take
1220 IF take < 1       THEN 1100
1230 IF take > maxtake THEN 1100

1300 REM 
1301 REM  Calculate the amount of tokens the computer is
1302 REM  going to take, and print it.
1303 REM 

1310 LET takes = maxtake + 1
1315 LET takes = takes   - take
1320 PRINT "Computer takes ";
1330 PRINT takes;
1340 IF takes = 1 THEN PRINT "token"
1345 IF takes > 1 THEN PRINT "tokens"

1400 REM 
1401 REM  Update the number of tokens, and check whether we're done.
1402 REM 

1410 tokens = tokens - 4
1420 IF tokens <> 0 THEN 1100

1500 REM 
1501 REM  We have won the game!
1502 REM 

1510 PRINT "Computer wins"
