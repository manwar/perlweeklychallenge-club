# Create a script that accepts two strings, let us call it, “stones” and “jewels”. 
# It should print the count of “alphabet” from the string “stones” found in the string “jewels”. 
# For example, if your stones is “chancellor” and “jewels” is “chocolate”, then the script should print “8”. 
# To keep it simple, only A-Z,a-z characters are acceptable. Also make the comparison case sensitive.

sub MAIN (
    Str $string1,   #= String to represent "stones"
    Str $string2    #= String to represent "jewels"
){
    if ($string1~$string2 ~~ /<-[A .. Za .. z]>/) {
        say "Only A-Z and a-z characters are allowed\n";
    } else {
        say ($string2.chars-$string2.trans( $string1 => "").chars);
    } 
}