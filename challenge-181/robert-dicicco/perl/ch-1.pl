#!perl.exe

use strict;
use warnings;
use Lingua::EN::Sentence qw/get_sentences/;

# AUTHOR: Robert DiCicco
# 2022-09-05
# Challenge # 181 Sentence Order ( Perl )

my $text = q{
All he could think about was how it would all end.
There was still a bit of uncertainty in the equation, but the basics were there for anyone to see.
No matter how much he tried to see the positive, it wasn't anywhere to be seen.
The end was coming and it wasn't going to be pretty.
};

my $sentences=get_sentences($text);     # Split $text into sentences

foreach my $sent (@$sentences) {                          # get each sentence
         $sent =~ s/\.//;                                 # remove periods
         my @result = split(/\s+/, $sent);                # split the sentence into words separated by spaces
         my @sorted = sort {lc($a) cmp lc($b)} @result;   # do a lower case sort of words
         print("@sorted\.\n");                            # and print the sorted result with a period terminator
}
