Challenge 363
https://theweeklychallenge.org/blog/perl-weekly-challenge-363/

Task 1: String Lie Detector
Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script that parses a self-referential string and determines whether its claims about itself are true. The string will make statements about its own composition, specifically the number of vowels and consonants it contains.

Example 1
Input: $str = "aa — two vowels and zero consonants"
Output: true

Example 2
Input: $str = "iv — one vowel and one consonant"
Output: true

Example 3
Input: $str = "hello - three vowels and two consonants"
Output: false

Example 4
Input: $str = "aeiou — five vowels and zero consonants"
Output: true

Example 5
Input: $str = "aei — three vowels and zero consonants"
Output: false

Task 2: Subnet Sheriff
Submitted by: Peter Campbell Smith
You are given an IPv4 address and an IPv4 network (in CIDR format).

Write a script to determine whether both are valid and the address falls within the network. For more information see the Wikipedia article.

Example 1
Input: $ip_addr = "192.168.1.45"
       $domain  = "192.168.1.0/24"
Output: true

Example 2
Input: $ip_addr = "10.0.0.256"
       $domain  = "10.0.0.0/24"
Output: false

Example 3
Input: $ip_addr = "172.16.8.9"
       $domain  = "172.16.8.9/32"
Output: true

Example 4
Input: $ip_addr = "172.16.4.5"
       $domain  = "172.16.0.0/14"
Output: true

Example 5
Input: $ip_addr = "192.0.2.0"
       $domain  = "192.0.2.0/25"
Output: true
