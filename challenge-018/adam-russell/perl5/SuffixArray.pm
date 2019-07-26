use strict;
use warnings; 
package SuffixArray{
use Data::Dump q/pp/; 
    use boolean;  
    use Class::Struct;
    struct(
        suffixes => q/@/
    );
    sub create{
        my($self, $text) = @_;
        for my $n (0 .. (length($text) - 1)){
            my @text_array = split(//, $text); 
            my $suffix = new Suffix(
                text => $text,
                text_array => \@text_array,
                index => $n                 
            );  
            $self->suffixes($n, $suffix); 
        } 
        my @a = sort {$a cmp $b} @{$self->suffixes()}; 
        $self->suffixes(\@a); 
    } 
    sub length{
        my($self) = @_;
        return @{$self->[0]}; 
    } 
    sub index{
        my($self, $i) = @_;  
        return $self->suffixes()->[$i]->index(); 
    }
    sub lcp{
        my($self, $i) = @_;  
        return $self->lcp_suffix($self->suffixes()->[$i], $self->suffixes()->[$i - 1]);   
    } 
    sub lcp_suffix{
        my($self, $a, $b) = @_;  
        my $length_a = $a->length();   
        my $length_b = $b->length();   
        my $n = $length_a < $length_b ? $length_a : $length_b; 
        for my $i (0..($n - 1)){
            if($a->char_at($i) ne $b->char_at($i)){
                return $i; 
            } 
        } 
        return $n;  
    }
    sub select{
        my($self, $i) = @_;  
        return $self->suffixes()->[$i]->text();  
    }    
    sub rank{
        my($self, $query) = @_;  
        my $low = 0;
        my $high = @{$self->[0]} - 1; 
        while($low <= $high){
            my $middle = int($low + ($high - $low) / 2); 
            my $comparison = $self->compare_string($query, $self->suffixes()->[$middle]);
            if($comparison < 0){
                $high = $middle - 1;
            }  
            elsif($comparison > 0){
                $low = $middle + 1;  
            } 
            else{
                return $middle;  
            }  
        }
        return $low;  
    }
    sub compare_string{
        my($self, $query, $suffix) = @_;
        return 0 if $query eq substr($suffix->text(), $suffix->index());  
        my $length_query = CORE::length($query); 
        my $length_suffix = CORE::length($suffix->text()); 
        my $n = $length_query < $length_suffix ? $length_query : $length_suffix; 
        my @q = split(//, $query); 
        for my $i (0 .. ($n - 1)){
            return -1 if($q[$i] lt $suffix->char_at($i)); 
            return  1 if($q[$i] gt $suffix->char_at($i)); 
        }  
    }  

    package Suffix{
        use Class::Struct 
            text => q/$/,
            text_array => q/@/,
            index => q/$/ 
        ; 
        use overload
            '<=>' => \&compare,
            'cmp' => \&compare;
        use boolean;
        sub compare{
            my($a, $b) = @_;   
            return 0 if substr($a->text(), $a->index()) eq substr($b->text(), $b->index());  
            my $length_a = length(substr($a->text(), $a->index())); 
            my $length_b = length(substr($b->text(), $b->index())); 
            my $n = $length_a < $length_b ? $length_a : $length_b; 
            for my $i (0 .. ($n - 1)){
                return -1 if($a->char_at($i) lt $b->char_at($i)); 
                return  1 if($a->char_at($i) gt $b->char_at($i)); 
            }  
        }  
        sub length{
            my($self) = @_;  
            return length($self->text()) - $self->index();  
        } 
        sub char_at{
            my($self, $i) = @_;  
            return $self->text_array()->[$self->index() + $i];   
        }  
        true; 
    }  
    true; 
} 
