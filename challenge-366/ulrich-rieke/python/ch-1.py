#!/usr/bin/env python3

sentence = input( "Enter a sentence with some words!\n" )
word = input ("Enter a word!\n" )
allWords = sentence.split( ' ' ) 
print( len( [w for w in allWords if word[0:len(w)] == w] ))
