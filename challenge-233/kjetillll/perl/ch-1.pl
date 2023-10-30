# take words from command line arguments or use the test case here:

my @words = @ARGV ? @ARGV: ("aba", "aabb", "abcd", "bac", "aabc");

print number_of_pairs_of_similar_but_not_equal_words(@words);
print "\n";


sub number_of_pairs_of_similar_but_not_equal_words {
    my $count = 0;
    "@_" =~ /                            #regex searching all word pairs in stringified input words
        (\b\w+\b)                        #word $1
        .*
        (\b\w+\b)                        #word $2
        (??{                             #means execute and try to match againts regexp-part in last statement
            $count++ if similar($1,$2);  #increase count if similar
            "^";                         #keep searching for ^ (beginning, which wont be found) till all pairs done for
        })
    /x;                                  #/regex/ modifier x ignores spaces, newlines and #comments
    $count;                              #return count
}

sub similar {
    letters($_[0]) eq letters($_[1])   #similar
    &&
    $_[0] ne $_[1]                     #but not equal
}


#helper function/normalizer
#returns string of distinct letters in alphabetical order
#abba becomes ab and challenge becomes aceghln
sub letters {
    my %found;
    for my $letter ( shift() =~ /[a-z]/gi ) {
	$found{$letter}=1;
    }
    join '', sort keys %found;
}

__END__

sub what_sane_people_would_do {
   my $count = 1;
   for my $f ( 0 .. $#_-1 ) {          #index first word in pair
       for my $s ( $f+1 .. $#_ ) {     #index second word in pair
	   $count++ if similar( $_[$f], $_[$s] );
       }
   }
   return $count;
}
