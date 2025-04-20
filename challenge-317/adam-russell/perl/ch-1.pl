
  
use v5.40; 

  
  sub acronyms{
      my($word_list, $word) = @_;
      my @first_letters = map{
          (split //, $_)[0]
      } @{$word_list};
      return 1 if $word eq join q//, @first_letters;
      return 0;
  }

  
MAIN:{
  say acronyms([qw/Perl Weekly Challenge/], q/PWC/);
  say acronyms([qw/Bob Charlie Joe/], q/BCJ/);
  say acronyms([qw/Morning Good/], q/MM/);
}

