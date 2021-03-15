#You are given a file containing a list of words (case insensitive 1 word per 
#line) and a list of letters. Print each word from the file that can be made 
#using only letters from the list. You can use each letter only once (though 
#there can be duplicates and you can use each of them once), you don’t have to
#use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)

use strict;
use warnings;

my ($filepath, $letters) = @ARGV;

my $regexp = join('|', split(//, $letters)); 

open(my $file, '<', $filepath);

while(my $cl = <$file>) {
    my $count = () = $cl =~ m/$regexp/g;
    $count >= (length($cl) - 1) ? print $cl : 0;
}

close $file;
