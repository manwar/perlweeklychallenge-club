#!/usr/local/bin/python3
import sys

# Task 1: Sort Language

# See https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK1 for more information on this challenge

# You are given two array of languages and its popularity.
# Write a script to sort the language based on popularity.

def main(argv):
    # Example 1
    lang = ('perl', 'c', 'python')
    popularity = (2, 1, 3)
    print( sort_languages(lang, popularity) )        
    #Output: ('c', 'perl', 'python')
    
    # Example 2
    lang = ('c++', 'haskell', 'java')
    popularity = (1, 3, 2)
    print( sort_languages(lang, popularity) )
    #Output: ('c++', 'java', 'haskell')
                
def sort_languages(lang,popularity):
    # Create a single list based on the two inputted lists
    sorted_langs_with_pop = sorted(zip(popularity,lang))
    # Created a sorted list using the above list but only with the languages
    sorted_langs = [lang for _,lang in sorted_langs_with_pop]
    return sorted_langs

if __name__ == "__main__":
   main(sys.argv[1:])
