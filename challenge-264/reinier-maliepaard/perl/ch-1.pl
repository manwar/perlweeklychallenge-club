sub greatest_english_letter {

   $str_ = shift;
   @matches = ();

   foreach $char ($str_ =~ /[A-Z]/g) {
     push(@matches, $char) if( index($str_, lc($char)) != -1 );
   }

   @matches = sort(@matches);
   ($matches[-1]) ? ( print($matches[-1] . "\n") ) : print("No match\n");
}

$str = 'PeRlwEeKLy';
greatest_english_letter($str);# Output: L

$str = 'ChaLlenge';
greatest_english_letter($str);# Output: L

$str = 'The';
greatest_english_letter($str);# Output: No match
