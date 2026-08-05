use v6 ;

sub remove_outermost( $input is copy ) {
#set current number to 0. On encountering an opening parenthesis, 
#add 1 to current number , otherwise subtract 1. Since our input is valid,
#we remove the opening parentheses with counter 1 and the closing parenth.
#with current number 0
   my $current_number = 0 ;
   my @letternumbers ;
   for $input.comb -> $letter {
      my @pair ;
      if ( $letter eq '(' ) {
         $current_number++ ;
      }
      else {
         $current_number-- ;
      }
      @pair.push( $current_number ) ;
      @pair.push( $letter ) ;
      @letternumbers.push( @pair ) ;
   }
   my $after_removal ;
   for @letternumbers -> @arr {
      if ( @arr[1] eq "(" && @arr[0] != 1 ) {
         $after_removal ~= "(" ;
      }
      if ( @arr[1] eq ")" && @arr[0] != 0 ) {
         $after_removal ~= ")" ;
      }
   }
   if ( $after_removal ) {
      return $after_removal ;
   }
   else {
      return "\"\"" ;
   }
}

say remove_outermost( "()()()") ;
say remove_outermost( "(((())))") ;
say remove_outermost( "(()())(())") ;
say remove_outermost( "()((()))()") ;
say remove_outermost( "(()(()))(()())" ) ;
