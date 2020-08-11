## 
# Create a script that either reads standard input 
# or one or more files specified on the command-line. 
# Count the number of times and then print a summary, 
# sorted by the count of each entry.
##
MAIN:{
    my %word_counts;
    while(<>){
        chomp; 
        $word_counts{$_}+=1;
    }  
    my @sorted_keys = sort {$word_counts{$b} <=> $word_counts{$a}} keys %word_counts;
    for my $key (@sorted_keys){
        print "$key\t$word_counts{$key}\n"; 
    } 
} 
