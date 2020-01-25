use v6 ;

#in order to create the analogon of list comprehensions, I had to create
#various functions to take account of differing numbers of digit
#combinations. Unfortunately, this led to code repetition.
#to print out the results of the gather-take loops turned out to be more
#difficult than originally envisaged
#somehow you have to circumvent the fact the immutability of resulting
#strings

sub createNumberString( @numbersequence ) {
    for @numbersequence -> @array {
      my $str = join '+' , @array ;
      $str ~~ s:g/\+\-/\-/ ;
      say $str ;
    }
}

sub testSubSequences_8( @numbers ) {
  my @sources ;
  for (0..7 ) -> $i {
      @sources.push( @numbers[ $i ] , -@numbers[ $i ] ) ;
  }
  my  @fittingnumbers = gather {
      for @sources[0,1] -> $n0 {
      for @sources[2,3] -> $n1 {
    for @sources[4,5] -> $n2 {
        for @sources[6,7] -> $n3 {
          for @sources[8,9] -> $n4 {
          for @sources[10,11] -> $n5 {
            for @sources[12,13] -> $n6 {
            for @sources[14,15] -> $n7 {
              if ( $n0 + $n1 + $n2 + $n3 + $n4 + $n5 + $n6 + $n7 )
              == 100 {
                  take $n0 , $n1 , $n2 , $n3 , $n4 , $n5 , $n6 ,
                  $n7 ;
              }
            }
            }
          }
          }
        }
    }
    }
      }
  }
  if @fittingnumbers {
      createNumberString( @fittingnumbers ) ;
  }
}

sub testSubSequences_7( @numbers ) {
  my @sources ;
  for (0..6 ) -> $i {
      @sources.push( @numbers[ $i ] , -@numbers[ $i ] ) ;
  }
  my @fittingnumbers = gather {
      for @sources[0, 1] -> $n0 {
    for @sources[2 , 3] -> $n1 {
        for @sources[4 , 5] -> $n2 {
          for @sources[6 , 7] -> $n3 {
          for @sources[8 , 9] -> $n4 {
            for @sources[10 , 11 ] -> $n5 {
            for @sources[12 , 13] -> $n6 {
              if ( $n0 + $n1 + $n2 + $n3 + $n4 + $n5 + $n6 )
              == 100 {
                  take $n0 , $n1 , $n2 , $n3 , $n4 , $n5 , $n6 ;
                  }
            }
            }
          }
          }
        }
    }
      }
  }
  if @fittingnumbers {
      createNumberString( @fittingnumbers ) ;
  }
}

sub testSubSequences_6( @numbers ) {
  my @sources ;
  for (0..5 ) -> $i {
      @sources.push( @numbers[ $i ] , -@numbers[ $i ] ) ;
  }
  my @fittingnumbers = gather {
      for @sources[0,1] -> $n0 {
    for @sources[2 , 3] -> $n1 {
        for @sources[4 , 5] -> $n2 {
          for @sources[6 , 7] -> $n3 {
          for @sources[8 , 9] -> $n4 {
            for @sources[10, 11] -> $n5 {
            if ( $n0 + $n1 + $n2 + $n3 + $n4 + $n5 )
              == 100 {
                  take $n0 , $n1 , $n2 , $n3 , $n4 , $n5 ;
              }
            }
            }
          }
          }
        }
    }
  }
  if @fittingnumbers {
      createNumberString( @fittingnumbers ) ;
  }
}

sub testSubSequences_5( @numbers ) {
  my @sources ;
  for (0..4 ) -> $i {
      @sources.push( @numbers[ $i ] , -@numbers[ $i ] ) ;
  }
  my @fittingnumbers = gather {
      for @sources[0, 1] -> $n0 {
    for @sources[2 , 3] -> $n1 {
        for @sources[4 , 5] -> $n2 {
          for @sources[6 , 7] -> $n3 {
          for @sources[8 , 9] -> $n4 {
          if ( $n0 + $n1 + $n2 + $n3 + $n4 )
            == 100 {
            take $n0 , $n1 , $n2 , $n3 , $n4 ;
          }
        }
    }
      }
      }
    }
  }
  if @fittingnumbers {
      createNumberString( @fittingnumbers ) ;
  }
}

sub testSubSequences_4( @numbers ) {
  my @sources ;
  for (0..3 ) -> $i {
      @sources.push( @numbers[ $i ] , -@numbers[ $i ] ) ;
  }
  my @fittingnumbers = gather {
      for @sources[0, 1] -> $n0 {
    for @sources[2 , 3] -> $n1 {
        for @sources[4, 5] -> $n2 {
          for @sources[6, 7] -> $n3 {
          if ( $n0 + $n1 + $n2 + $n3 ) == 100 {
            take $n0 , $n1 , $n2 , $n3 ;
          }
          }
        }
    }
      }
  }
  if @fittingnumbers {
      createNumberString( @fittingnumbers ) ;
  }
}

#function to find the substrings and numbers according to length sequences
sub findNumbers( Str $digits , $seq ) {
  my @numbers ;
  my $current = 0 ;
  for $seq.Array -> $i {
      @numbers.push( $digits.substr( $current , $i ).Int) ;
      $current += $i ;
  }
  return @numbers ;
}


my $digits = "123456789" ;
#a combination of 3 three-digit-numbers will not result in 100 as a sum!
#therefore, the likely combinations in length are : ( all summing up to 9)
my @likelyCombos = ( (1 , 2 , 2 , 2 , 2 ) , (1 , 1 , 1 , 1 , 1 , 2 , 2 ),
      (3 , 2 , 2 , 2 ) , ( 1 , 2 , 3 , 2 , 1 ) , ( 3 , 3 , 2 , 1 ) ,
      ( 3 , 3 , 1 , 1 , 1 ) , (1 , 1 , 1 , 1 , 1 , 1, 1, 2) ) ;
#we now permutate these combinations and form substrings , that is numbers
#accordingly, preserving the order of digits

#the dispatcher helps to select the right list comprehension depending on
#length of the @numbers array!
my %dispatcher =
  4 => &testSubSequences_4 ,
  5 => &testSubSequences_5 ,
  6 => &testSubSequences_6 ,
  7 => &testSubSequences_7 ,
  8 => &testSubSequences_8 ;

say "+ and - can be inserted in the following ways:" ;
for @likelyCombos -> $combo {
  my $selectedOp = %dispatcher{ $combo.elems } ;
  my @permus = $combo.permutations.unique(:with(&[eqv])) ;
  for @permus -> $permutation {
      my @numbers = findNumbers( $digits , $permutation ) ;
      $selectedOp( @numbers ) ;
  }
}
