#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub trim($str) {
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    return $str;
}

sub stringLieDetector($str) {
    state %numbers = (
        'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4,
        'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9,
        'ten' => 10, 'eleven' => 11, 'twelve' => 12,
    );
    
    my ($content, $claims) = split q{—}, $str;
    unless (defined $content && defined $claims) {
        return false;
    }
    
    $content = lc trim($content);
    $claims = trim($claims);
    
    my $vowelCount = 0;
    my $consonantCount = 0;
    
    for my $char (split //, $content) {
        if ($char =~ /[aeiou]/) {
            $vowelCount++;
        } elsif ($char =~ /[bcdfghjklmnpqrstvwxyz]/) {
            $consonantCount++;
        }
    }
    
    my $claimedVowels;
    my $claimedConsonants;
    
    if ($claims =~ /(\w+) \s+ vowel/x) {
        $claimedVowels = $numbers{lc $1};
    }

    if ($claims =~ /(\w+) \s+ consonant/x) {
        $claimedConsonants = $numbers{lc $1};
    }
    
    my $vowelMatch = $vowelCount == $claimedVowels;
    my $consonantMatch = $consonantCount == $claimedConsonants;
    
    my $defVowels = defined $claimedVowels;
    my $defConsonants = defined $claimedConsonants;
    
    return $defVowels && $defConsonants && $vowelMatch && $consonantMatch;
}

my ($str) = @ARGV;

say stringLieDetector($str) ? 'true' : 'false';