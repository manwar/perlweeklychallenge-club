## 
# Create a script that either reads standard input 
# or one or more files specified on the command-line. 
# Count the number of times and then print a summary, 
# sorted by the count of each entry.
##
sub MAIN{
    my %word_counts;
    for $*IN.lines -> $line {
        $line.chomp; 
        %word_counts{$line}+=1;
    }  
    for %word_counts.sort(*.value).reverse -> $pair {
        say $pair.key ~ "\t" ~ $pair.value; 
    } 
} 
