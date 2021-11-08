010 REM 
020 REM See ../README.md
030 REM 

040 REM 
050 REM Run as: basic.pl ch-1.bas < input-file
051 REM Input file should be terminated with a 0.
060 REM 

100 INPUT n
110 IF n = 0 THEN END
150 s = s + n
160 c = c + 1
170 PRINT s / c
200 GOTO 100
