#!usr/bin/perl
use v5.36;


# Challenge 216 - 1 - Registration Number
# You are given a list of words and a random registration number.
# Write a script to find all the words in the given list that has every letter in the given registration number.

regNum('AB1 2CD', ('abc', 'abcd', 'bcd'));      # abcd
regNum('007 JB',  ('job', 'james', 'bjorg'));   # ('job', 'bjorg')
regNum('C7 RA2',  ('crack', 'road', 'rac'));    # ('crack', 'rac')

sub regNum($reg, @wordlist)
{
    $reg =~ s"\d|\s""g; 

    my @resultArr;

    OUTER:
    foreach my $word (@wordlist)
    {
        foreach my $char (split('', $reg))
        {
            next OUTER  if( $word !~ /$char/i)
        }
        push(@resultArr, $word);
    }
    
    say join(', ', @resultArr);
}