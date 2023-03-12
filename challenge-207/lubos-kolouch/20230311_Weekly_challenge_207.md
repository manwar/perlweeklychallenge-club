# THE WEEKLY CHALLENGE - 207

### 

https://theweeklychallenge.org/blog/perl-weekly-challenge-207/

**March 11th, 2023**

## Task 1 - How to Check if a Word is Typable with a Single Keyboard Row

We all know the feeling of typing out a long word and suddenly realizing that you had to switch keyboard rows to do it. Well, now there's a way to check if a word can be typed using only one row of a standard QWERTY keyboard!

This Perl code snippet uses a hash map to store the keyboard layout, then checks it against a given word to see if it can be typed using only one row:

```perl
#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

my @keyboard_rows = qw(qwertyuiop asdfghjkl zxcvbnm);
my %keyboard_map;

# Create a hash map to store the keyboard layout
for my $i ( 0 .. 2 ) {
    my $row = $keyboard_rows[$i];
    $keyboard_map{$_} = $i + 1 for split( '', $row );
}

# Function to check if a word can be typed using only one row of the keyboard
sub is_single_row_word {
    my ($word) = @_;
    my $row = $keyboard_map{ lc( substr( $word, 0, 1 ) ) };
    for my $c ( split( '', lc($word) ) ) {
        return 0 if $keyboard_map{$c} != $row;
    }
    return 1;
}

# Test example 1
my @words1            = ( "Hello", "Alaska", "Dad", "Peace" );
my @single_row_words1 = grep { is_single_row_word($_) } @words1;
is_deeply( \@single_row_words1, [ "Alaska", "Dad" ], "Example 1" );

# Test example 2
my @words2            = ( "OMG", "Bye" );
my @single_row_words2 = grep { is_single_row_word($_) } @words2;
is_deeply( \@single_row_words2, [], "Example 2" );

done_testing();
```

This code uses the `grep` function to filter a list of words and return the ones that can be typed using only one row of the keyboard. For example, the list `"Hello", "Alaska", "Dad", "Peace"` would return `"Alaska", "Dad"` as these are the only two words that can be typed with a single row.

Now you can be sure that you're not typing words that require two different keyboard rows!

## Task 2 - Unlocking the Mysteries of the H-Index with Perl

Have you ever wanted to know your H-Index? It's not a mystery anymore! With the help of Perl, you can figure out your own H-Index in no time.

An H-Index is the largest number h such that h articles have at least h citations each. This is used to measure the impact of a researcher's work.

Here is how to calculate your H-Index using Perl.

First, you need to use strict and warnings in your code.

```perl
use strict;
use warnings;
```

Then, you should use feature 'say' to make your code more readable.

```perl
use feature 'say';
```

Next, you will need to include the Test::More module. This will allow you to run tests on your code.

```perl
use Test::More;
```

Now, you can create a subroutine to calculate your H-Index.

```perl
sub h_index {
    my @citations        = @_;
    my $n                = scalar @citations;
    my $h                = 0;
    my @sorted_citations = sort { $b <=> $a } @citations;

    for ( my $i = 0 ; $i < $n ; $i++ ) {
        if ( $sorted_citations[$i] >= $i + 1 ) {
            $h = $i + 1;
        }
        else {
            last;
        }
    }
    return $h;
}
```

Finally, you can run tests on your code to make sure it is working correctly.

```perl
# Run the tests
my @citations_1 = ( 10, 8, 5, 4, 3 );
my $h_index_1   = h_index(@citations_1);
is( $h_index_1, 4, "Test Example 1" );

my @citations_2 = ( 25, 8, 5, 3, 3 );
my $h_index_2   = h_index(@citations_2);
is( $h_index_2, 3, "Test Example 2" );

done_testing();
```

And there you have it! You can now calculate your own H-Index using Perl.
