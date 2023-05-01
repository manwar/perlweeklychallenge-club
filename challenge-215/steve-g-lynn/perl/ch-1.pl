#!/usr/bin/env -S perl -wl

#-- this script conforms to perl 4 syntax as specified
#-- in the 1st edition of Programming perl (pink camel)
#

local *odd_one_out = sub {
  local (@words)=@_;
  
  local *is_sorted = sub { #not idiomatic but I prefer readable
    local ($string)=@_;
    local $chk=join('',sort {$a cmp $b} split(//,$string));
    return ($string eq $chk);
  };
  
  local ($ctr, $word, @retval); $ctr=0;
  for $word (@words) {
    if (&is_sorted($word)) {
        push @retval, $word;
    } 
    else {
        $ctr++;
    }
  }
  print $ctr;
  return @retval;
};

print &odd_one_out('abc','xyz','tsu'); 
print &odd_one_out('rat','cab','dad');
print &odd_one_out('x','y','z');
