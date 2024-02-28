# Perl 4.019 on DOSBOX

sub count_even_digits {
 scalar( grep( ((length($_) % 2) == 0), @_) );
}

print &count_even_digits(10,1,111,24,1000),"\n"; #3
print &count_even_digits(111,1,11111),"\n"; #0
print &count_even_digits(2,8,1024,256),"\n"; #1
