# Create a script that accepts two strings, let us call it, “stones” and
# “jewels”. It should print the count of “alphabet” from the string “stones”
# found in the string “jewels”. For example, if your stones is “chancellor” and
# “jewels” is “chocolate”, then the script should print “8”. To keep it simple,
# only A-Z,a-z characters are acceptable. Also make the comparison case
# sensitive.

# I hope I understood the exercise.
sub count_abc(Str $stones, Str $jewels) {
    $jewels.comb.grep({$_ (elem) $stones.comb.Set}).elems;
}

count_abc('chancellor', 'chocolate').say;
