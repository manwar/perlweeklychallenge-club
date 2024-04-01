sub most_frequent_unbanned_word {
    my($paragraph,$banned)=@_;
    my %frequency;
    my $letters='a-z';
    $frequency{$_}++ for $paragraph=~/[$letters]+/gi;
    delete $frequency{$banned};
    ( sort{ $frequency{$b} <=> $frequency{$a} or $a cmp $b} keys %frequency )[0]
}

use Test::More;
is( most_frequent_unbanned_word("Joe hit a ball, the hit ball flew far after it was hit.",
                                "hit") => 'ball' );
is( most_frequent_unbanned_word("Perl and Raku belong to the same family. Perl is the
                                 most popular language in the weekly challenge.",
                                "the") => 'Perl' );
done_testing;
