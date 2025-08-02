task2(Str) :- re_replace("[^aeiou]"/ig, "", Str, Vowels_Only), string_length(Vowels_Only, Vowel_Count), Vowel_Count mod 2 =:= 0.
