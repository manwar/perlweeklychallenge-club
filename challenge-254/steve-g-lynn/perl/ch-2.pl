#perl 4.019 on DOSBOX

sub reverse_vowels {
 local(@s)=split(//,$_[0]);
 local(@reverse_vowels)=grep($s[$_] =~ /[aeiouAEIOU]/, 0..$#s);
 @s[@reverse_vowels]=@s[reverse(@reverse_vowels)];
 &ucfirst(&lc(join('',@s)));
}

sub lc {
 local($lc)=$_[0];
 $lc =~ tr/A-Z/a-z/;
 $lc;
}

sub ucfirst {
 local($ucfirst)=$_[0];
 substr($ucfirst,0,1) =~ tr/a-z/A-Z/;
 $ucfirst;
}


print &reverse_vowels('Raku'),"\n"; #Ruka
print &reverse_vowels('Perl'),"\n"; #Perl
print &reverse_vowels('Julia'),"\n"; #Jaliu
print &reverse_vowels('Uiua'),"\n"; #Auiu
