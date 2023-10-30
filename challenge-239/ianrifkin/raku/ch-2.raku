use v6;

# Task 2: Consistent Strings
# You are given an array of strings and allowed string having distinct characters.
# A string is consistent if all characters in the string appear in the string allowed.


# Example 1
my @str = ("ad", "bd", "aaab", "baa", "badab");
my $allowed = "ab";
check_allowed($allowed, @str);

# Example 2
@str = ("a", "b", "c", "ab", "ac", "bc", "abc");
$allowed = "abc";
check_allowed($allowed, @str);    

# Example 3
@str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d");
$allowed = "cad";
check_allowed($allowed, @str);

sub check_allowed {
    my ($allowed, @str) = @_;
    my $success_count = 0;
    # Loop through each item in array of strings
  item_loop: for @str {
      # Loop through each character in string to check in allowed list
    letters_loop: for $_.comb -> $letter {
	LAST if $allowed.contains($letter) {
	    $success_count++; #increment success if the last letter is in allowed list
	}
	# try next str item if a letter doesn't match
	letters_loop.last unless $allowed.contains($letter);

	# by default if letter matches and isn't last try next letter
    }
  }
    say($success_count);
}

