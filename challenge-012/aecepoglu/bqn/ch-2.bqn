# Challenge 2
#
#Write a script that finds the common directory path, given 
#a collection of paths and directory separator. For example, 
#if the following paths are supplied.

d←"/a/b/c/d"‿"/a/b/cd"‿"/a/b/cc"‿"/a/b/c/d/e"
⊑⌽(⊑∘⌽¨'/'=⊢)⊸/⊏⍉((1=+´∘∊)˘/⊢)⍉d↑˜⌜1+↕⌊´≠¨d
