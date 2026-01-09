#!/usr/bin/env perl

## N.B. no specific version of Perl used
use strict;
use warnings;
use Test::More;  # << Why is he doing this?
use Data::Dumper;

# Array of hashrefs.  The correct/intended answers are specified in out => x
my @examples = (
    { in  => [ "Hello world",
               "This is a test",
               "Perl is great" ],
      out => 4,
    },
    {
      in  => [ "Single" ],
      out => 1,
    },
    {
      in  => [ "Short",
               "This sentence has seven words in total",
               "A B C",
               "Just four words here" ],
      out => 7,
    },
    {
      in  => [ "One",
               "Two parts",
               "Three part phrase",
               "" ],
      out => 3,
    },
    {
      in  => [ "The quick brown fox jumps over the lazy dog",
               "A",
               "She sells seashells by the seashore",
               "To be or not to be that is the question" ],
      out => 10,
    },
);

# iterate over the array elements in the @examples array of hashrefs
# What is 'is', part of Test::More?
# max_word is the subroutine below
# The arrayref which is the value of the hash key 'in'
# gets passed to the subroutine
# I infer that the code element that occurs 
# AFTER 'is' and before the comma ',' gets
# compared to the answer returned by the code
# AFTER the command and before the for loop:

is max_word($_->{in}), $_->{out} for @examples;

done_testing; # This must be from Test::More(?)


## Passing in an arrayref, why is it only $_[0]?  Let's look and see
## I think the map converts each sentence into
## the number of words, so @w is an array of the number of
## words.  Got that?  Nice succinct trick
sub max_word {
    # Somehow this gives an array, oh, because it is
    # and arrayref of an arrayref (I think)
    # spell it out, the first arrayref has a single element, 
    # and arrayref, so $_[0] is also an arrayref
    # and when you dereference it you have an array, and now
    # you map the counts.  Okay
    my @w = map { scalar split } @{$_[0]};
    # print Data::Dumper->new([\@w],[qw(@w)])->Indent(1)->Quotekeys(0)->Dump, "\n";
    # exit;
    # stuff in parentheses gets evaluated to provide a number
    # if the array named @w exists (has content? remember testing for that elsewhere?
    # then do the comparison, otherwise return 0+0
    # The sort is the same as everybody used, no doubt
    # Very succinct coding.  Anonymous output from sorting
    # @w is unnamed, and you only want the first element [0]
    # The return value is what gets compared

    return 0+(@w ? (sort {$b <=> $a} @w)[0] : 0);
}

__END__
His output from running this script on my laptop:
ok 1
ok 2
ok 3
ok 4
ok 5
1..5

Must be from Test::More(?)
