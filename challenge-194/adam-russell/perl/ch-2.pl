use v5.34;
##
# Given a string made of letters a-z write a script to determine
# whether removing only one character can make the frequency of the
# remaining characters the same.
##
use boolean;
use Data::Dump q/pp/;
sub frequency_equalizer{
    my($s) = @_;
    my %h;
    my %frequency_start;
    my %frequency_end;
    my @letters = split(//, $s); 
    map {$h{$_} = undef} @letters;  
    my @unique_letters = sort keys %h;
    {
        my $c = pop @unique_letters;
	my $count;
	my @letters_one_removed = grep {$_ ne $c || $_ eq $c &&  $count++ >= 1} @letters;
	map {$frequency_start{$_}++} @letters;
        map {$frequency_end{$_}++} @letters_one_removed;
        my @start;
        my @end;
	map { if(exists($frequency_start{$_})){
                  push @start, $frequency_start{$_};
	      }
	      else{
                  push @start, -1;
	      } 
	} sort keys %h;
	map { if(exists($frequency_end{$_})){
                  push @end, $frequency_end{$_};
	      }
	      else{
                  push @end, -1;
	      } 
	} sort keys %h;
	return true if 0 == grep {$end[$_] != $end[$_ + 1]} 0 .. @end - 2;   
        %frequency_start = ();
        %frequency_end = ();
	redo unless !@unique_letters;
    }
    return false; 
}

MAIN:{
    say frequency_equalizer(q/abbc/);
    say frequency_equalizer(q/xyzyyxz/);
    say frequency_equalizer(q/xzxz/);
}
