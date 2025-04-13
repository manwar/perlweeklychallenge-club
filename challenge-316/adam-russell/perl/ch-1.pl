
  
use v5.40; 

  
  sub circular{
      my $current = shift @_;
      my $current_last = (split //, $current)[length($current) - 1];
      do{
          my $previous_last = $current_last;
          $current = $_;
          my $current_first = (split //, $current)[0];
          $current_last = (split //, $current)[length($current) - 1];
          return 0 if $previous_last ne $current_first;
      } for @_;
      return 1;
  }

  
MAIN:{
  say circular(qw/perl loves scala/);
  say circular(qw/love the programming/);
  say circular(qw/java awk kotlin node.js/);
}

