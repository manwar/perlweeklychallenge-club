# Write a script to accept a string from command line and split it on change of
# character. For example, if the string is “ABBCDEEF”, then it should split
# like “A”, “BB”, “C”, “D”, “EE”, “F”.

sub MAIN(Str $str="ABBCDEEF") {
    map({$_.Str.say}, $str ~~ m:g/(.)$0*/);
}

# Regular expression explained:
#
# m:g     --> Match global adverb, i.e. match repeatedly.
#   (.)   --> Match one character (with variable name $0).
#   $0*   --> Match zero or more times character $0.
