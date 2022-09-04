#Challenge #2
#    You are given a file containing a list of words (case insensitive 1 word per line) and a list of letters. Print each word from the file that can be made using only letters from the list. You can use each letter only once (though there can be duplicates and you can use each of them once), you don’t have to use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)

a←'a'+↕1+'z'-'a' # alphabet
b←"asnotehusbsathkrca"(+˝=⌜)a # my allowance for each letter
∧´b≥"emre"(+˝=⌜)a # checking if I have allowance for "emre"
b⊸(∧´⊣≥⊢(+˝=⌜)a˙)¨⊸/ •FLines "input.txt" # selecting those from words ones I have allowance for
