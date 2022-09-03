#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       second-to-none.pl
#
#       First Unique Character
#         Submitted by: Mohammad S Anwar
#         You are given a string, $s.
# 
#         Write a script to find out the first unique character in the
#         given string and print its index (0-based).
# 
#         Example 1
#             Input:  $s = "Perl Weekly Challenge"
#             Output: 0 as 'P' is the first unique character
# 
#         Example 2
#             Input:  $s = "Long Live Perl"
#             Output: 1 as 'o' is the first unique character
#
# 
#       analysis:
# 
#         Another combination-of-actions styled task to start us off this
#         week. I find these hybrid operations interestig, as the focus
#         ultimately falls on the synthesis between the parts, rather than
#         any one bold insight.
# 
#         In this case we need a list of unique characters and a lookup to
#         find where the first instance of each character lies. We can then
#         use these pieces in onformation together to find the first unique
#         instance of a character.
# 
#         Neither of the two requirements is particularly difficult to
#         implement. It would be straightforward to iterate across the
#         characters in the string and hash the number of instances of each
#         character, and when we get to the end those characters with a
#         frequency of 1 will be unique. We could then look at each
#         candidate and log its first position. THe closest one to the
#         front wins.
# 
#         That's however would be tedious, and require multiple passes
#         across the string to come to a conclusion. In every case to
#         satisfy the uniqueness quality we will need to pass over every
#         character in the string at least once. Can we make the call in a
#         single pass, though?
# 
#         Sure. We just need to record the right data when we make it.
# 
#         There are only so many characters available. Twenty-six letters
#         in the English alphabvet, 127 in ASCII, 256 if we extend the
#         range into 1-byte characters. How many Unicode characters are
#         there now? 15,000? Anyways a lot, but not that many in the great
#         scheme of things. We're counting character varieites not protons.
# 
# 
#       method:
# 
#         We'll use substr to examine each character in turn. We could
#         store everything in a single data structure, but as we've noted
#         even a hash with every character as a key would not be
#         extraoridinarily large. And hash lookups are effectively constnat
#         with no regard to scaling anyway. Big, little — the hashes don't
#         care.
# 
#         So for clarity we build two hashes. In one, we store the first
#         instance of a value. In the second, we identify whether the
#         character is unique.
# 
#         On selecting a candidate character, we first look to find a key
#         in the second, `%common` hash. If it's there we immediately
#         discard the candidate and move on. We don't care a whit *how*
#         unique a character is, only whether it its or it isn't.
# 
#         If it is not found in the `%common` lookup, then two things
#         happen: we make two new hash entires, one in the aforementioned
#         hash to note it has been already seen, and in the other we record
#         the character and its position. We'll call this hash `%first`.
# 
#         If it is not found in the `%common` lookup, then we turn to the
#         second hash. We'll call this hash `%position`, for position. If the
#         character already exists as a key here, then it's not unique, and
#         if fact it's common. We make a new key in the `%common` hash,
#         delete the entry in the `%position` hash and move on. On the other
#         hand if we don't already find it there then the character is, at
#         that moment, still considered unique. We add its position to the
#         `%position` hash under a new key.
# 
#         When we reach the end of the line we've gathered everythign we
#         need to know. The `%position` hash contains unique keys mapped to
#         unique positions, as of course no two characters can hold the
#         smae index in a string. To find the smallest value, instead of
#         laboriously sorting the hash by value we can instead reverse the
#         hash. After all, we know the values are unique, so they will make
#         unique keys.
# 
#         Sorting the keys of this reversed hash yields the smallest
#         numeric position, which can then be looked up to find the
#         character found at that spot.
# 
#         
#         
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my $str = shift //  'abcdeabcdf'; ##'prophylaxis';

my %common;
my %position;
my $pos = 0;

## pass over string and record data
while ($pos < length $str) {
    my $char = substr $str, $pos++, 1;
    next if $common{$char};
    if ($position{$char}) {
        $common{$char} = 1;
        delete $position{$char};
        next;
    }
    $position{$char} = $pos;
}
my ($result) = sort { $position{$a} <=> $position{$b} } keys %position;
say $result;

%position = reverse %position;  ## magic

## output value from smallest position, now a key
say $position{ (sort {$a<=>$b} keys %position )[0] };
