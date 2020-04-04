use v6;


# Vowel Strings

# Write a script to accept an integer 1 <= N <= 5 that would print all possible strings of size N formed by using only vowels (a, e, i, o, u).

# The string should follow the following rules:

    # ‘a’ can only be followed by ‘e’ and ‘i’.

    # ‘e’ can only be followed by ‘i’.

    # ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.

    # ‘o’ can only be followed by ‘a’ and ‘u’.

    # ‘u’ can only be followed by ‘o’ and ‘e’.
#ae
#ai
#ei
#ia
#io
#iu
#ie
#oa
#ou
#uo
#ue


my @aStrings = ();
 my %hNodes = ();
%hNodes{'a'} = ['e','i'];
%hNodes{'e'} = ['i'];
%hNodes{'i'} = ['a', 'e', 'o', 'u'];
%hNodes{'o'} = ['a','u'];
%hNodes{'u'} = ['a','e'];

sub MAIN ( Int $size ) {    
    unless (defined($size) && $size  >= 1 && $size <= 5 ) {
        die "ERROR: Size must be between 1 and 5\n";
    }   
    for  keys(%hNodes) -> $vowel {
        addVowel($size, $vowel,'');
    }    
    @aStrings.sort.map({  say  $_    });
    
}

sub addVowel ($currentLevel, $currentVowel , $currentString) {

    my $addToString  =  $currentString ~  $currentVowel; 
    my $newLevel = $currentLevel -1;
    if $currentLevel  == 1   {
        @aStrings.push($addToString );
        return 0;
    }        
    for  @(%hNodes{$currentVowel}) -> $nextVowel {   
        addVowel($newLevel, $nextVowel,$addToString  );
    }    
    return 0;
}

