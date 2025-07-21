
sub f {
    my($a, $b) = @_;
    $a =~ /^ #match from beginning of string $a
      (.*)   #substring before first swapped letter
      (.)    #first swapped letter
      (.*)   #substring between the two swapped letters
      (.)    #second swapped letter
      (.*)   #substring after the second swapped letter
     $       #match up to end of string $a
     (??{    #make the regexp engine try and retry different lengths of the three (.*) parts
             #until the swapped string equals $b. Or it will give up with false as a result.
       my $trial = "$1$4$3$2$5"; # $a with two letters swapped
       $trial eq $b   #check if the trial string now equals $b
       ? ''           #if so, no need to match anything more thus '', and the regex and also f() returns true
       : '^'          #make this trial fail with the impossible ^ match (beginning of string),
                      #and if no more trials the regex and also f() returns false
     }) 
    /x                # /x ignores regexp whitespace and allows #comments
}

#sub f{my($a,$b)=@_;$a=~/^(.*)(.)(.*)(.)(.*)$(??{"$1$4$3$2$5"eq$b?'':'^'})/}

print f("fudge", "fduge") ? "ok\n" : "err\n";  # true
print f("love", "love")   ? "err\n" : "ok\n";  # false
print f("fodo", "food")   ? "ok\n" : "err\n";  # true
print f("feed", "feed")   ? "ok\n" : "err\n";  # true

print f("perl", "erlp")   ? "err\n" : "ok\n";  # false
print f("perl", "prel")   ? "ok\n" : "err\n";  # true
print f("regexp challenge", "regexp challenge") ? "ok\n" : "err\n";  # true, l and l swapped
print f("regexp challenge", "regexg challenpe") ? "ok\n" : "err\n";  # true
print f("challenge", "challegne") ? "ok\n" : "err\n";  # true
print f("challenge", "challeneg") ? "ok\n" : "err\n";  # true
print f("challenge", "hcallenge") ? "ok\n" : "err\n";  # true
print f("challenge", "hcallegne") ? "err\n" : "ok\n";  # false, needs two swaps
