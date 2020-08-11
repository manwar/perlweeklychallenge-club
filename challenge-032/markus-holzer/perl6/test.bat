@echo off
type simpsons.txt|call perl6 ch-1-and-2.pl6
type simpsons.txt|call perl6 ch-1-and-2.pl6 --csv 
call perl6 ch-1-and-2.pl6 simpsons.txt simpsons.txt 
call perl6 ch-1-and-2.pl6 simpsons.txt --graph
call perl6 ch-1-and-2.pl6 --csv simpsons.txt --sort-by-label
