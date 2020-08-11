use strict;
use warnings;
use Data::Dumper;

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



my $size = $ARGV[0];
unless (defined($size) && $size =~ /^[1-5]{1}$/ ) {
    die "ERROR: Size must be between 1 and 5\n";
}


my %hNodes = ();
$hNodes{'a'} = ['e','i'];
$hNodes{'e'} = ['i'];
$hNodes{'i'} = ['a', 'e', 'o', 'u'];
$hNodes{'o'} = ['a','u'];
$hNodes{'u'} = ['a','e'];

my @aStrings = ();


foreach my $vowel ( keys(%hNodes)){
    addVowel($size, $vowel,'');
}

sub addVowel {
    my $currentLevel = shift;
    my $currentVowel = shift;
    my $currentString = shift;
    $currentString  .= $currentVowel;   
    if ($currentLevel  == 1  ){
        push (@aStrings , $currentString);
        return 0;
    } else {
        $currentLevel--;
    }       
        
    foreach my $nextVowel (@{$hNodes{$currentVowel}}){   
        addVowel($currentLevel, $nextVowel,$currentString );
    }
    
    return 0;
}   
foreach my $str (sort @aStrings){
    print "$str\n";

}

