#perl 4.019 on DOSBOX

sub merge_strings {
 local( @str1 ) = split(//,$_[0]);
 local( @str2 ) = split(//,$_[1]);
 local($max_len)= (($#str1 > $#str2) ? $#str1 : $#str2);
 local( @retval )=();
 local( $i );
 foreach $i (0 .. ($max_len)){
  defined($str1[$i]) && push( @retval, $str1[$i] ) ;
  defined($str2[$i]) && push( @retval, $str2[$i] ) ;
 }
 join( "", @retval);
}

print &merge_strings("abcd","1234"),"\n"; #a1b2c3d4
print &merge_strings("abc","12345"),"\n"; #a1b2c345
print &merge_strings("abcde","123"),"\n"; #a1b2c3de
