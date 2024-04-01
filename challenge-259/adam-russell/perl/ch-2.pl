
  
use v5.38;

use Ch2;
use constant TEST0 => q/{%  id    field1="value1"    field2="value2"    field3=42 %}/;
use constant TEST1 => q/{%  youtube title="Title \"quoted\" done" %}/; 
use constant TEST2 => q/{%  youtube title="Title with escaped backslash \\\\" %}/; 

  
sub print_record{
  my($record) = @_; 
  say q/{/;
  say qq/\tname => / . $record->{name}; 
  say qq/\tfields => {/; 
  for my $field (sort {$a cmp $b} keys %{$record->{fields}}){
      say qq/\t\t$field => / . q/ / . $record->{fields}->{$field}; 
  }  
  say qq/\t}/; 
  say q/}/;
}

  
MAIN:{
  my $parser = Ch2->new();
  say TEST0; 
  print_record($parser->parse(TEST0)); 
  say TEST1; 
  print_record($parser->parse(TEST1)); 
  say TEST2; 
  print_record($parser->parse(TEST2)); 
}  

