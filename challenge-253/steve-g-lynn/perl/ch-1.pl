# Perl 4.019 on DOSBOX

sub split_strings {
 local ($separator, @words)=@_;
 local (@retval)=(); #array to be returned

 #-- prefix $separator with '\\' to escape it in case it is
 #-- a meaningful regex character like '.' or '$'
  
 $separator = '\\' . $separator;
 local (@split_strings)=();
 
 foreach (@words) {

  @split_strings = split(/$separator/,$_);

  foreach (@split_strings) {      

   #-- push to @retval only if item is not an empty string
   $_ && push( @retval, $_ );

  }

 }
 @retval;
}

print join( ",", &split_strings('.', 'one.two.three', 'four.five', 'six') ),"\n";
#one,two,three,four,five,six

print join( ",", &split_strings('$', '$perl$$', '$$raku$') ),"\n";
#perl,raku
