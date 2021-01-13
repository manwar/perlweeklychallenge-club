#Palindrome Dates
#Write a script to print all Palindrome Dates between 2000 and 2999. 
#The format of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is represented as 10022001.  

use v6;

for 2000..2999 {
    my $mmdd = $_.flip;
    my $date = Date.new($_,  $mmdd.substr(0,2), $mmdd.substr(2,2));
    CATCH {
        default {  }
    }
    say $mmdd ~ $_;      
}