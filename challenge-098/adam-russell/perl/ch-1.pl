use strict;
use warnings;
##
# You are given file $FILE.
# Create subroutine readN($FILE, $number) returns the 
# first n-characters and moves the pointer to the (n+1)th character.
##
sub read_maker0{
    my $n = 0;
    return sub{
        my($file, $x) = @_;
        my $chars;
        open(FILE, $file);
        unless(seek(FILE, $n, 0)){
            close(FILE);
        }
        read(FILE, $chars, $x);
        $n = $n + $x;
        return $chars;
    }
}

sub read_maker1{
    my ($file) = @_;
    my $n = 0;
    open(FILE, $file);
    return sub{
        my($x) = @_;
        my $chars;
        my $read = read(FILE, $chars, $x);
        $n = $n + $x;
        unless(seek(FILE, $n, 0)){
            close(FILE);
        }
        return $chars;
    }
}

MAIN:{
    my($FILE, $number) = ("ch-1.dat", 4);
    my($read_n, $chars);
    $read_n = read_maker0();
    $chars = $read_n->($FILE, $number);
    print "$chars\n";
    $chars = $read_n->($FILE, $number);
    print "$chars\n";
    $chars = $read_n->($FILE, $number);
    print "$chars\n";
    
    
    $read_n = read_maker1($FILE);
    $chars = $read_n->($number);
    print "$chars\n";
    $chars = $read_n->($number);
    print "$chars\n";
    $chars = $read_n->($number);
    print "$chars\n";
}