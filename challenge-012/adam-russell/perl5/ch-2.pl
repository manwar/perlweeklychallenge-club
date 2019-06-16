use strict;
use warnings;
##
# Write a script that finds the common directory path, 
# given a collection of paths and directory separator.
##
use boolean;  

##
# Main
##
my @paths; 
my $common_path; 
my $seperator = <DATA>;  
chomp($seperator);  
while(<DATA>){
    push @paths, [split(/\Q$seperator\E/, $_)]; 
}  
for(my $i=0; $i < @paths; $i++){
    my $in_common = true; 
    my $directory = shift @{$paths[$i]}; 
    for(my $j=0; $j < @paths; $j++){
        if($j != $i){  
            my $d = shift @{$paths[$j]}; 
            if($directory && ($d ne $directory)){
                $in_common = false;            
                last;   
            }
        }
    }
    if($in_common){
        $common_path .= $directory . $seperator;   
    } 
    else{
        last; 
    } 
} 
chop($common_path);  
print "Path in common is $common_path.\n";  

__DATA__
/
/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e
