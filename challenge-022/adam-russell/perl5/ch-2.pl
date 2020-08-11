use strict;
use warnings;
##
# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
##
use constant TABLE_SIZE => 256;

sub initialize_table{
    my $code = 0; 
    my %compression_table;
    do{
        $compression_table{chr($code)} = $code++;
    }while($code < TABLE_SIZE); 
    return %compression_table; 
}  

sub encode{
    my($string) = @_;
    my %compression_table = initialize_table();
    my $code = keys %compression_table; 
    my @encoded;
    my @characters = split(//, $string); 
    my $p = shift @characters; 
    while(@characters){
        my $c = shift @characters; 
        if($compression_table{"$p$c"}){
            $p = "$p$c"; 
        } 
        else{
            push @encoded, $compression_table{$p};  
            $compression_table{"$p$c"} = $code++;
            $p = $c; 
        }  
    }
    push @encoded, $compression_table{$p};  
    return @encoded; 
}

sub decode{
    my(@codes) = @_;
    my %decoding_table = reverse(initialize_table());
    my $code = keys %decoding_table; 
    my $string = ""; 
    my $p = shift @codes;
    my $c; 
    $string = $decoding_table{$p};
    while(@codes){
        $c = shift @codes;
        my $entry = $decoding_table{$c}; 
        $string .= $entry;
        my $first_character = substr($entry, 0, 1);     
        my $string_previous = $decoding_table{$p};
        $decoding_table{$code++} = "$string_previous$first_character"; 
        $p = $c; 
    }  
    return $string; 
}  

MAIN:{
    my $text = <DATA>;
    chomp($text); 
    initialize_table();  
    print join(" ", encode($text));  
    print "\n"; 
    print decode(encode($text));  
    print "\n"; 
}  


__DATA__
Abra abracadabra
