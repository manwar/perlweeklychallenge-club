# Perl Weekly Challenge - 005
# Challenges #1 and #2
# (This program solves both challenges.)
#
# See
#     engineering.purdue.edu/~mark/pwc-005.pdf
# for more information.

# Run using Perl 6.
use v6;


#
#  Challenge #1.
#

# Read the words in "words6.txt" to @word.
my @word = lines 'words6.txt'.IO;

# Define %hash.
# Each key is a string with the letters in lexigraphic order.
# Each value is an array of words that use those letters.
my Array %hash;

# Construct the array.
for (@word)
{
    # The key for "family" is "amfily".
    my $key = .comb(/./).sort.join;
    # Add the current word to the hash.
    %hash{$key}.push($_);
}

# Print the array.
# for (%hash.keys.sort) -> $key
# {
#     print "$key:";
#     for (%hash{$key}.Array)
#     {
#         print " $_";
#     }
#     print "\n";
# }

# Pick a random word.
my $word = @word.pick;

# Convert $word to $key.
my $key = $word.comb(/./).sort.join;

# Print the output.
print "Challenge 1\n";
print "print all anagrams for a word\n";
print "original word: $word\n";
print "anagrams:     ";
for (%hash{$key}.Array.sort)
{
    ($word eq $_)  or  print " $_";
}
print "\n";


#
#  Challenge 2.
#

my $n = 0;
for (%hash.keys)
{
    my $t = %hash{$_}.Array.elems;
    if ($t > $n)
    {
        $n = $t;
        $key = $_;
    }
}

# Print the output
print "\n";
print "Challenge 2\n";
print "sequence of letters with most anagrams\n";
print "letters:  $key\n";
print "anagrams:";
for (%hash{$key}.Array.sort)
{
    ($word eq $_)  or  print " $_";
}
print "\n";
