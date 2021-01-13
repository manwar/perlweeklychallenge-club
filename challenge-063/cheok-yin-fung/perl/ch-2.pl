#!/usr/bin/perl
use strict;

my $word = $ARGV[0];
my $wordlen = length $word;

sub lookup_repeated {
    my $word = $_[0];
    my $le = 1;
    while ($le <= $wordlen/2) {
        my $multiple = int $wordlen/$le;
        if ($wordlen == $le * $multiple) {
            my $pattern = substr $word, 0, $le;
            if ( ($pattern x $multiple) eq $word ) {
                return $le;
            } 
            else {
                $le++;
            }
        } 
        else {
            $le++;
        }
    }
    return $wordlen if $le > $wordlen/2 ;
}

my $patternlen = lookup_repeated $ARGV[0];

if ($patternlen == 1) {
    print "1";
    exit;
}


my $tri_no = 1;
my $i = 1;

while ($tri_no % $patternlen != 0) {
    $i++;
    $tri_no += $i;
}

print $i;
print "\n";
