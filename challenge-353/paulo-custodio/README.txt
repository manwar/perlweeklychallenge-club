Challenge 353
https://theweeklychallenge.org/blog/perl-weekly-challenge-353/

Task 1: Max Words
Submitted by: Mohammad Sajid Anwar
You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single sentence.

Example 1
Input: @sentences = ("Hello world", "This is a test", "Perl is great")
Output: 4

Example 2
Input: @sentences = ("Single")
Output: 1

Example 3
Input: @sentences = ("Short", "This sentence has seven words in total", "A B C", "Just four words here")
Output: 7

Example 4
Input: @sentences = ("One", "Two parts", "Three part phrase", "")
Output: 3

Example 5
Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")
Output: 10

Task 2: Validate Coupon
Submitted by: Mohammad Sajid Anwar
You are given three arrays, @codes, @names and @status.

Write a script to validate codes in the given array.

A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
- status[i] is true.
Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid.

Example 1
Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
       @names  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery")
       @status = ("true", "false", "true", "true", "true")
Output: (true, false, true, false, true)

Example 2
Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
       @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown")
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, false)

Example 3
Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
       @names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery")
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, true)

Example 4
Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
       @names  = ("electronics", "electronics", "grocery", "grocery")
       @status = ("true", "true", "true", "true")
Output: (true, true, true, true)

Example 5
Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
       @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics")
       @status = ("true", "true", "true", "true", "false")
Output: (true, true, true, true, false)
