# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
#
# You have a broken keyboard which sometimes type a character more than once.
# You are given a string and actual typed string.
# Write a script to find out if the actual typed string is meant for the given string.
# 
# Example 1
# Input: $name = "perl", $typed = "perrrl"
# Output: true
# Here "r" is pressed 3 times instead of 1 time.
#
# Example 2
# Input: $name = "raku", $typed = "rrakuuuu"
# Output: true
#
# Example 3
# Input: $name = "python", $typed = "perl"
# Output: false
#
# Example 4
# Input: $name = "coffeescript", $typed = "cofffeescccript"
# Output: true

def broken_keyboard(name, typed):
    freq = {}
    for char in name:
        if char in freq:
            freq[char] += 1
        else:
            freq[char] = 1
    for char in typed:
        if char in freq:
            freq[char] -= 1

    print("name '%s' typed '%s' -> %s" %  
            (name, typed,
             len([v for v in freq.values() if v < 0]) > 1
            )
         )

if __name__ == "__main__":
    name = "perl"
    typed = "perrrl"
    broken_keyboard(name, typed)

    name = "raku"; typed = "rrakuuuu"
    broken_keyboard(name, typed)

    name = "python"; typed = "perl"
    broken_keyboard(name, typed)

    name = "coffeescript"; typed = "cofffeescccript"
    broken_keyboard(name, typed)
