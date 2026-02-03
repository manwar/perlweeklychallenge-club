# The Weekly Challenge 358

The second challenge in this week's [Weekly Challenge](https://theweeklychallenge.org/blog/perl-weekly-challenge-358/) was intresting because it allowed some intresting progression exploring some more advanced python language features.

The challenge itself is to develop a character substitution cypher that uses a fixed offset.

> You are given a string `$str` and an integer `$int`.
>
> Write a script to encrypt the string using the algorithm - for each character `$char` in `$str`, replace `$char` with the `$int`th character after `$char` in the alphabet, wrapping if needed and return the encrypted string.
>
> **Example 1**
> ```
> Input: $str = "abc", $int = 1
> Output: "bcd"
> ```

And, from my thinking the core of the challenge is to play with modulo arithmatic so that the wrapping of an in greater than the number of letters in the alphabet is handled.

## Solution 1
Focusing on the core of the challange I develop my first solution:

    def encrypt(text: str, shift: int) -> str:
        codebook = 'abcdefghijklmnopqrstuvwxyz'
        size = len(codebook)
        ctoi = {c:i for i,c in enumerate(codebook)}
        itoc = {i:c for c,i in ctoi.items()}

    
        out = (itoc[(ctoi[c] + shift) % size] for c in text)
        out = ''.join(out)

        return out

I hope the code does not need too much explanation. 

I have assumed, based on the challenge test cases, that the solution only has to work over the english lowercase alphbet. Using the alphabet two dictionary are created to map from a charcter to is position in the alphabet and the inverse position to character.

The solution then iterates over each character shifting is position and adjusting for for the wrapping: `itoc[(ctoi[c] + shift) % size]`

So, while this feet like a correct solution, with a small nod to the [generator comprehension](https://peps.python.org/pep-0289/) which allows for lazy computation of the string substitiution. There were two things that felt I would want to do to improve:

1. Abstracting the dictionary code so that this was not recomputed for every call to the function
1. Developing some approach to handling input that was badly formed. IE. Not just lowercase letters.

## Solution 2
The next soluution deals with the seperation of the setup from the encryption by refactoring the standalone functions into a class abstracting the setup code into the constructor to that the encrypt method does not have to perform this for every call.

    class Encryptor():
        def __init__(self, codebook):
            self.codebook = codebook
            self.size = len(self.codebook)
            self.ctoi = {c:i for i,c in enumerate(self.codebook)}
            self.itoc = {i:c for c,i in self.ctoi.items()}

        def encrypt(self, text, shift):
            out = (self.itoc[(self.ctoi[c] + shift) % self.size] for c in text)
            out = ''.join(out)
            return out

