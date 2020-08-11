perl -E 'say for grep { 100 == eval } glob join "{+,-,}", 1..9;'
