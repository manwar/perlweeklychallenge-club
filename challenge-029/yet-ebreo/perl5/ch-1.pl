#!/usr/bin/env perl
# Write a script to demonstrate brace expansion. 
# For example, script would take command line argument 
# Perl {Daily,Weekly,Monthly,Yearly} Challenge and should expand it and print like below:
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge
use strict;
use warnings;
use feature 'say';

die "Usage:\n\tch-1.pl <string>\n\n" if @ARGV < 1;
die "Requires exactly one(1) string\n" if @ARGV > 1;
#Note(s):
#   - The script needs exactly one string enclosed with ""
#   - Unmatched braces will not be expanded
#   - The words will be printed in order that they appear inside the {}

#Remove empty braces before processing using substitution
#    The /r returns the result without modifying the $ARGV[0] variable
#Then the resulting string will be used in recusrive function expand
expand($ARGV[0]=~s/{}//gr);

sub expand {
    #The string will be stored in $string
    my $string = shift;

    #- Regex was used to check if the string contains matching braces
    #- Notice that [^{}]* instead of a simple .* to match the contents of the braces
    #      this is to make sure that the inner most brace is processed first
    #- The matching string was captured using () and will be stored in $1
    if ($string =~ /{([^{}]*)}/) {
        # The captured value, the prematch and postmatch were stored
        # in variables $l,$m and $r respectively
        my ($l,$m,$r) = ($`,$1,$');
        # The captured value stored in $m was split using comma(,) as delimiter
        # The resulting list was used in a for loop
        for (",$m"=~/,([^,]*)/g) {
            #A new string containing the prematch, a value from the split operation of $m
            #and the postmatch will be used in the recursive function.
            #The process will be repeated until...
            expand($l.$_.$r);
        }
    } else {
        #The string does not have matching braces.
        #Then final string will be printed
        say $string;
    }
}
=begin
perl ch-1.pl "Perl {Daily,Weekly,Monthly,Yearly} Challenge"
Perl Daily Challenge
Perl Weekly Challenge
Perl Monthly Challenge
Perl Yearly Challenge

perl ch-1.pl "{The,A} quick {brown,gray} fox jumps over the lazy {dog,cow}"
The quick brown fox jumps over the lazy dog
The quick brown fox jumps over the lazy cow
The quick gray fox jumps over the lazy dog
The quick gray fox jumps over the lazy cow
A quick brown fox jumps over the lazy dog
A quick brown fox jumps over the lazy cow
A quick gray fox jumps over the lazy dog
A quick gray fox jumps over the lazy cow

--------------------------
#Some edge/tricky cases
--------------------------
#No brace
perl ch-1.pl "Perl Challenge"
Perl Challenge

#Nested braces
perl ch-1.pl "Perl {{Daily,Weekly},Monthly,Yearly} Challenge"
Perl Daily Challenge
Perl Monthly Challenge
Perl Yearly Challenge
Perl Weekly Challenge
Perl Monthly Challenge
Perl Yearly Challenge

#Unmatched brace
perl ch-1.pl "Perl {daily,monthly Challenge"
Perl {daily,monthly Challenge
perl ch-1.pl "Perl daily,monthly} Challenge"
Perl daily,monthly} Challenge

#Empty braces
perl .\ch-1.pl "Perl {}Weekly{} Challenges"
Perl Weekly Challenges
=cut

