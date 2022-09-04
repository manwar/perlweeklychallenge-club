# Week 12
# Challenge 1
#     The numbers formed by adding one to 
# the products of the smallest primes are 
# called the Euclid Numbers (see wiki). 
# Write a script that finds the smallest 
# Euclid Number that is not prime.

IsPrime←{0=∨´0=𝕩|˜2↓↕⌈2÷˜𝕩}
p←/ (1<n) {𝕩∧¬𝕨(≠∧(0=|))n}´⌽ 2↓ n←↕100# sieve based primes
1+×`p # euclid numbers
⊑(¬∘IsPrime¨/⊢)7↑1+×`p
