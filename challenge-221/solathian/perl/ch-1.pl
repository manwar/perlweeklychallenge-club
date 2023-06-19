#!usr/bin/perl
use v5.36;
use Algorithm::Combinatorics qw(permutations);
use builtin qw(true false);

no warnings 'experimental';

# Challenge 221 - 1 - Good Strings
# A string is good if it can be formed by characters from $chars, each character can be used only once.

goodStrMain("atach",          ["cat", "bt", "hat", "tree"]);
# The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.

goodStrMain("welldonehopper", ["hello", "world", "challenge"]);
# The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.




# checks if the word can be constructed from the given string's chars
sub isContained($string, $word, $resultArray)
{
    my @tempChars   = split('', $string);
    my $retVal      = true;

    foreach my $wordChar (split('', $word))
    {

        # check if each character is in the @ chars array
        if($wordChar ~~ @tempChars)
        {
            my $tempString  = join('', @tempChars);
            $tempString     =~ s/$wordChar//;
            @tempChars      = split('', $tempString);
        }
        else
        {
            $retVal = false;
        }
    }
    
    # if the $string can be constructed from the given $charArray, set the resultArray
    if($retVal == true)
    {
        $resultArray = \@tempChars
    }
    
    return $retVal;    
    
}

sub goodStr($string, $wordList)
{

    my @matchingWords;
    my $newString = $string;
    
    foreach my  $word (@$wordList)
    {
        if( isContained($string, $word, \my @newCharList))
        {
            $newString = join('', @newCharList);
            push(@matchingWords, $word)
        }
       
    }
    return \@matchingWords;
}


sub goodStrMain($string, $wordList)
{
    my $maxSum = 0;
    my $goodMaxStr = [];
    
    # this is done since I was lazy to check if the order of the elements has any significance
    foreach my $wordlistPermutation (permutations($wordList))
    {
        my $goodStrRef = goodStr($string, $wordlistPermutation);
        my $sum = 0;
        
        
        foreach my $goodString ( @$goodStrRef)
        {
            
            $sum += length($goodString);
        }
        
        if( $sum > $maxSum  )
        {
            $maxSum = $sum;
            $goodMaxStr = $goodStrRef;
        }
    }

    print join(',', @$goodMaxStr);
    say " : $maxSum";
}