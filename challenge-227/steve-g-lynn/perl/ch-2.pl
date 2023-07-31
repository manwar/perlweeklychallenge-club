#!/usr/bin/env -S perl -wl

use Math::Roman qw(roman);

sub roman_maths {
    my ($string)=@_;
    
    ($string =~ /([IVXLCMD]+)\s*([+-\/\*]\**)\s*([IVXLCMD]+)/)
        || die 'Invalid input';
     
     
     ( ($2 eq '-') && ($1 eq $3) ) && return 'nulla';
     
     ( ($2 eq '-') && ( roman($1) < roman($3) ) ) && 
        return 'non potest';
     
     ( ($2 eq '/') && ( (roman($1) % roman($3) ) > 0 ) ) &&
        return 'non potest';
        
     my $roman=eval("roman($1) $2 roman($3)"); 
     if ($roman > 3999) {
        return 'non potest';
     }
     else {
        return $roman;
    }
}


print 'IV+V: ' . &roman_maths('IV+V');
print 'M-I: ' . &roman_maths('M-I');
print 'X/II: ' . &roman_maths('X/II');
print 'XI*VI: ' . &roman_maths('XI*VI');
print 'VII**III: ' . &roman_maths('VII**III');
print 'V-V: ' . &roman_maths('V-V');
print 'V/II: ' . &roman_maths('V/II');
print 'MMM+M: ' . &roman_maths('MMM+M');
print 'V-X: ' . &roman_maths('V-X');

