# Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20. 
# However, any number divisible by 3 should be replaced by the word ‘fizz’ and 
# any divisible by 5 by the word ‘buzz’. Those numbers that are both divisible 
# by 3 and 5 become ‘fizzbuzz’.

say $_ % 15??$_ % 5??$_ % 3??$_!!'fizz'!!'buzz'!!'fizzbuzz' for 1..20