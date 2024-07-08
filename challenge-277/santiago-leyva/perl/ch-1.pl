use strict;
use Data::Dumper;

my @words1 = ("Perl", "is", "my", "friend");
my @words2 = ("Perl", "and", "Raku", "are", "friend");

#my @words1 = ("Perl", "and", "Python", "are", "very", "similar");
#my @words2 = ("Python", "is", "top", "in", "guest", "languages");

#my @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional");
#my @words2 = ("Crystal", "is", "similar", "to", "Ruby");

#You are given two array of strings, @words1 and @words2.

#Write a script to return the count of words that appears in both arrays exactly once.

my %hash1;
my %hash2;
my $counter;

for(my $i;$i<(scalar @words1);$i++){
    if(!exists($hash1{$words1[$i]})){
    $hash1{$words1[$i]} = '';
    next;
    }else{
    delete $hash1{$words1[$i]};
    }
}
for(my $i;$i<(scalar @words2);$i++){
    if(exists($hash1{$words2[$i]})){
    $counter+=1;
    }
}

print $counter;