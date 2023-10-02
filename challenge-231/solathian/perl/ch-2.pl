#!usr/bin/perl
use v5.38;

# Challenge 231 - 2 - Task 2: Senior Citizens

use constant SENIOR => 60;

senior("7868190130M7522", "5303914400F9211","9273338290F4010");     # 2
senior("1313579440F2036", "2921522980M5644");                       # 0
senior("7868190130M7522");                                          # 1
senior();                                                           # 0

sub senior(@list)
{
    my $string = join("<>", @list) . "<>";      # to keep the regexp simple
    my @ages   = $string =~ m"(\d{2})\d{2}<>"g;     
    
    say scalar grep{ $_ >= SENIOR} @ages;

}