
## Example 1
## arrWords_01 = ["Perl", "is", "my", "friend"]
## arrWords_02 = ["Perl", "and", "Raku", "are", "friend"]

## Example 2
## arrWords_01 = ["Perl", "and", "Python", "are", "very", "similar"]
## arrWords_02 = ["Python", "is", "top", "in", "guest", "languages"]

## Example 3
arrWords_01 = ["Perl", "is", "imperative", "Lisp", "is", "functional"]
arrWords_02 = ["Crystal", "is", "similar", "to", "Ruby"]

arrOutput = [strLoop for strLoop in set(arrWords_01 + arrWords_02) if arrWords_01.count(strLoop) == 1 and arrWords_02.count(strLoop) == 1]

print (len(arrOutput))
