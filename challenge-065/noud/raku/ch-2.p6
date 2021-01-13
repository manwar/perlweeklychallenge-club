# You are given a string $S. Write a script print all possible partitions that
# gives Palindrome. Return -1 if none found.
#
# Please make sure, partition should not overlap. For example, for given string
# “abaab”, the partition “aba” and “baab” would not be valid, since they
# overlap.
#
# Example 1
#
# Input: $S = 'aabaab'
# Ouput:
#  There are 3 possible solutions.
#  a) 'aabaa'
#  b) 'aa', 'baab'
#  c) 'aba'
#
# Example 2
#
# Input: $S = 'abbaba'
# Output:
#  There are 3 possible solutions.
#  a) 'abba'
#  b) 'bb', 'aba'
#  c) 'bab'


# I don't understand the task. In my oppinion a single character is a
# palindrome as well. Also I don't agree that 'aba' of string 'aabaab' is a
# palindrome, because the rest of the string 'a' and 'ab' are not taken into
# account. Even if you add the extra restriction that every palindrome should
# have at least 2 characters, the string 'aabaab' also has to solution 'aa' and
# 'aa'.
#
# I created two other solutions instead:
# 1. weak-palindromes, where non-used parts are allowed.
# 2. strong-palindromes, where the whole string has to be used.

sub all-partitions-weak($S) {
    if ($S.chars == 1) {
        return [[$S],];
    }

    my @ret = [[$S],];
    for 1..($S.chars - 1) -> $i {
        for $i..($S.chars - 1) -> $j {
            my $s1 = $S.substr(0, $i);
            my $s2 = $S.substr($j, $S.chars);
            for all-partitions-weak($s2) -> $r {
                @ret.push([$s1, |($r)]);
            }
            @ret.push([$s1]);
            @ret.push([$s2]);
        }
    }

    return @ret;
}

sub all-partitions-strong($S) {
    if ($S.chars == 1) {
        return [[$S],];
    }

    my @ret = [[$S],];
    for 1..($S.chars - 1) -> $i {
        my $s1 = $S.substr(0, $i);
        my $s2 = $S.substr($i, $S.chars);
        for all-partitions-strong($s2) -> $r {
            @ret.push([$s1, |($r)]);
        }
    }

    return @ret;
}

sub all-palindrome(@A) {
    for @A -> $a {
        if (not $a.flip eq $a) {
            return False;
        }
    }
    return True;
}

say 'Weak palindromes:';
all-partitions-weak('aabaab').grep({ all-palindrome($_ ); }).say;
all-partitions-weak('abbaba').grep({ all-palindrome($_ ); }).say;

say 'Strong palindromes:';
all-partitions-strong('aabaab').grep({ all-palindrome($_ ); }).say;
all-partitions-strong('abbaba').grep({ all-palindrome($_ ); }).say;

# With the extra restriction of at least two characters for a palindrome.

sub at-least-two(@A) {
    for @A -> $a {
        if ($a.chars < 2) {
            return False;
        }
    }
    return True;
}

say 'Weak palindromes (len > 1):';
all-partitions-weak('aabaab').grep({
    all-palindrome($_ ) and at-least-two($_);
}).say;
all-partitions-weak('abbaba').grep({
    all-palindrome($_ ) and at-least-two($_);
}).say;

say 'Strong palindromes (len > 1):';
all-partitions-strong('aabaab').grep({
    all-palindrome($_ ) and at-least-two($_);
}).say;
all-partitions-strong('abbaba').grep({
    all-palindrome($_ ) and at-least-two($_);
}).say;
