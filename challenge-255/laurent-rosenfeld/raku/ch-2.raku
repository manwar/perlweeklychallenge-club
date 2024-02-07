sub most-frequent-word ($para is copy, $banned) {
    $para ~~ tr/,.:;?!//;
    my $histo = $para.words.grep({$_ ne $banned}).Bag;
    return $histo.keys.max({$histo{$_}});
}

my $t = "Joe hit a ball, the hit ball flew far after it was hit.";
printf "%-30s... => ", substr $t, 0, 28;
say most-frequent-word $t, "hit";

$t = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
printf "%-30s... => ", substr $t, 0, 28;
say most-frequent-word $t, "the";
