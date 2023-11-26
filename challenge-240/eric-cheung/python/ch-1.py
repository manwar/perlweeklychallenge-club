
## Example 1
## arrStrInput = ["Perl", "Python", "Pascal"]
## strCheck = "ppp"


## Example 2
## arrStrInput = ["Perl", "Raku"]
## strCheck = "rp"


## Example 3
arrStrInput = ["Oracle", "Awk", "C"]
strCheck = "oac"

print ("".join([strLoop[0].lower() for strLoop in arrStrInput]) == strCheck)
