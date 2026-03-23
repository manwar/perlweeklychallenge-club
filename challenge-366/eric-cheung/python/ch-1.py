
## Example 1
## arrWords = ["a", "ap", "app", "apple", "banana"]
## strInput = "apple"

## Example 2
## arrWords = ["cat", "dog", "fish"]
## strInput = "bird"

## Example 3
## arrWords = ["hello", "he", "hell", "heaven", "he"]
## strInput = "hello"

## Example 4
## arrWords = ["", "code", "coding", "cod"]
## strInput = "coding"

## Example 5
arrWords = ["p", "pr", "pro", "prog", "progr", "progra", "program"]
strInput = "program"

arrOutput = [strLoop for strLoop in arrWords if strInput.startswith(strLoop)]

print (len(arrOutput))
