# Perl 4.019 on DOSBOX

sub odd_character {
 local($s,$t)=@_;
 
 #I leave out input validation chores.
 #We assume that $t is a jumbled version of $s
 #plus one extra character
 #that we have to find and return
 local(%s,%t,$i);
 foreach $i (split(//,$s)) {
  $s{$i}++;
 }
 foreach $i (split(//,$t)) {
  $t{$i}++;
 }
 foreach $i (keys %t) {
  ($t{$i} > $s{$i}) && (return $i);
 }
 return "ERROR";
}

print &odd_character("Perl","Preel"),"\n"; #e
print &odd_character("Weekly","Weeakly"),"\n"; #a
print &odd_character("Box","Boxy"),"\n"; #y
