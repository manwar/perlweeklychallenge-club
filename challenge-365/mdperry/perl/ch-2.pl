#!/usr/bin/env perl

use v5.38;


=head1 COMMENTS


 Task 2: Valid Token Counter

 You are given a sentence.

 Write a script to split the given sentence into space-separated tokens and count how many are valid words.
 A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters,
 and at most one punctuation mark (!, ., ,) appearing only at the end.
 / / / / / / / / / / / / / / / / / / / / / / / / / / / / 

 Okay, we need to build up a regex pattern match.  The beginning and end are fairly straightforward
 ^[a-z]+ will match one or more lc letters at the start
 [!.,]?$ will match one optional punctuation mark, but only at the end of the pattern

 In the middle there is one, optional, hyphen which then has to have one or more lc letters.
 My first attempt at this did not work for all of the examples:
 -?[a-z]+

 but after some research, testing, and trial and error, I ended up with this instead:
 (?:-[a-z]+)? so the hyphen is optional, but if there is a hyphen, you need to have at least one
              (or more) letters.

 Putting them all together, this now works correctly with all of the examples:

 ^[a-z]+(?:-[a-z]+)?[!.,]?$


=cut


my %examples = ( Example_1 => "cat and dog",
		 Example_2 => "a-b c! d,e",
		 Example_3 => "hello-world! this is fun",
                 Example_4 => "ab- cd-ef gh- ij!",
		 Example_5 => "wow! a-b-c nice.",
	     );

foreach my $example ( sort keys %examples ) {
    my $str = $examples{$example};
    my @tokens = split(/\s/, $str);
    # we will autoincrement this every time we find a valid match
    my $valid_word_count = 0;
    foreach my $token ( @tokens ) {
        # numerals are not allowed in valid tokens
        next if $token =~ m/[0-9]/;
        if ( $token =~ m/^[a-z]+(?:-[a-z]+)?[!.,]?$/ ) {
            $valid_word_count++;
	}
    }
    print "$example\n";
    print "Input: \$str = \"", $str, "\"\n";
    print "Output: $valid_word_count\n\n";
}


__END__

Results from running this Script:

Example_1
Input: $str = "cat and dog"
Output: 3

Example_2
Input: $str = "a-b c! d,e"
Output: 2

Example_3
Input: $str = "hello-world! this is fun"
Output: 4

Example_4
Input: $str = "ab- cd-ef gh- ij!"
Output: 2

Example_5
Input: $str = "wow! a-b-c nice."
Output: 2


