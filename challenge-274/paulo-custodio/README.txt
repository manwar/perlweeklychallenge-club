Perl Weekly Challenge 274
https://theweeklychallenge.org/blog/perl-weekly-challenge-274/

Task 1: Goat Latin
Submitted by: Mohammad Sajid Anwar
You are given a sentence, $sentence.

Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.

Rules for Goat Latin:

1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa" to
   the second word, etc etc.
Example 1
Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"
Example 2
Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
Example 3
Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

Task 2: Bus Route
Submitted by: Peter Campbell Smith
Several bus routes start from a bus stop near my home, and go to the same stop in town. They each run to a set timetable, but they take different times to get into town.

Write a script to find the times - if any - I should let one bus leave and catch a strictly later one in order to get into town strictly sooner.

An input timetable consists of the service interval, the offset within the hour, and the duration of the trip.

Example 1
Input: [ [12, 11, 41], [15, 5, 35] ]
Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5 minutes past (5, 20, ...) and takes 35 minutes.

At 45 minutes past the hour I could take the route 1 bus at 47 past the hour, arriving at 28 minutes past the following hour, but if I wait for the route 2 bus at 50 past I will get to town sooner, at 25 minutes past the next hour.
Example 2
Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]
