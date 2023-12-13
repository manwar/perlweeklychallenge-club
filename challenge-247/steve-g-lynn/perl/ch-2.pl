#!/usr/bin/env -S perl -wl

local *most_frequent_letter_pair = sub {
    local ($s)=@_;
    local %s;
    foreach (0 .. (length($s)-2)) {
        $s{substr($s,$_,2)}++;
    }
    return (sort { ($s{$b} <=> $s{$a}) || ($a cmp $b)} keys %s) [0];
};

print &most_frequent_letter_pair( 'abcdbca' ); #bc
print &most_frequent_letter_pair( 'cdeabeabfcdfabgcd' ); #ab
