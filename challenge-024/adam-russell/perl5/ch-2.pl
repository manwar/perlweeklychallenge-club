use strict;
use warnings;
##
# Create a script to implement full text search functionality using Inverted Index.
##
use boolean; 
use constant DATA_DIR => "./data/";

sub index_contents{
    my($index, $file) = @_;
    my %seen; 
    my $contents; 
    do{
        local $/;
        open(F, $file);
        $contents = <F>;
        $contents =~ tr/-/ /;
        $contents =~ s/[^[:ascii:]]//g;
        $contents =~ s/[[:punct:]]//g;
        close(F);  
    }; 
    my $d = DATA_DIR;
    $file =~ s/$d//g; 
    my @words = split(/\s+/, $contents);
    @words = map { lc($_) } @words;
    for my $word (@words){
        if(!$index->{$word}){
            $index->{$word} = [$file];
            $seen{$word} = true; 
        }  
        if($index->{$word} && !$seen{$word}){
            push @{$index->{$word}}, $file;
            $seen{$word} = true; 
        }
    }       
} 

sub print_index{
    my($index) = @_; 
    my($word, $documents); 
    format INDEX_HEADER =
        ------------------------------------------------------------------------------------------------------
        |Word           |         Documents                                                                  |
        ------------------------------------------------------------------------------------------------------
.
    format INDEX =
        |@<<<<<<<<<<<<<<|@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<|
        $word, $documents
.
    format INDEX_FOOTER =
        ------------------------------------------------------------------------------------------------------
.
    $~ = "INDEX_HEADER"; 
    write;

    $~ = "INDEX"; 
    for my $w (sort keys %{$index}){
        $word = $w;
        $documents = join(", ", @{$index->{$w}});
        write;  
    } 

    $~ = "INDEX_FOOTER"; 
    write;
} 

MAIN:{
    my %index; 
    opendir(DATA, DATA_DIR);
    while(my $file = readdir(DATA)){
        if(-f DATA_DIR.$file){
            index_contents(\%index, DATA_DIR.$file); 
        }  
    }
    close(DATA); 
    print_index(\%index); 
}  
