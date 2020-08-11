##
# Create a script that accepts one or more files 
# specified on the command-line and count the 
# number of times letters appeared in the files.
##
sub MAIN {
    my %letter_count; 
    for $*IN.lines() -> $line {
        my @characters = $line.split("");
        for @characters -> $c {
            %letter_count{$c}++ if $c~~m/<alpha>/; 
        } 
    } 
    for sort keys %letter_count -> $key {
        print "$key: %letter_count{$key}\n";
    }  
} 
