#!/usr/bin/env raku

sub stringLieDetector(Str $str) {
    state %numbers = (
        'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4,
        'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9,
        'ten' => 10, 'eleven' => 11, 'twelve' => 12,
    );
    
    my ($content, $claims) = $str.split(/<[—-]>/);
    
    unless defined $content && defined $claims {
        return False;
    }
    
    $content = $content.trim.lc;
    $claims = $claims.trim;
    
    my $vowelCount = 0;
    my $consonantCount = 0;
    
    for $content.comb -> $char {
        if $char ~~ /<[aeiou]>/ {
            $vowelCount++;
        } elsif $char ~~ /<[bcdfghjklmnpqrstvwxyz]>/ {
            $consonantCount++;
        }
    }
    
    my $claimedVowels;
    my $claimedConsonants;
    
    if $claims ~~ /(\w+) \s+ vowel/ {
        $claimedVowels = %numbers{$0.lc};
    }

    if $claims ~~ /(\w+) \s+ consonant/ {
        $claimedConsonants = %numbers{$0.lc};
    }
    
    my $vowelMatch = $vowelCount == $claimedVowels;
    my $consonantMatch = $consonantCount == $claimedConsonants;
    
    my $defVowels = defined $claimedVowels;
    my $defConsonants = defined $claimedConsonants;
    
    return $defVowels && $defConsonants && $vowelMatch && $consonantMatch;
}

# Main
sub MAIN(
    Str $str
) {
        say stringLieDetector($str);
}
