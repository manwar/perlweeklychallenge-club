#! /usr/bin/env perl6

use Readline;

my %a;

%a<0> = q:to/END/;
   ,a8888a,     
 ,8P"'  `"Y8,   
,8P        Y8,  
88          88  
88          88  
`8b        d8'  
 `8ba,  ,ad8'   
   "Y8888P"     
END

%a<1> =q:to/END/;
    88  
  ,d88  
888888  
    88  
    88  
    88  
    88  
    88  
END

%a<2> =q:to/END/;
 ad888888b,  
d8"     "88  
        a8P  
     ,d8P"   
   a8P"      
 a8P'        
d8"          
88888888888  
END

%a<3> =q:to/END/;
 ad888888b,  
d8"     "88  
        a8P  
     aad8"   
     ""Y8,   
        "8b  
Y8,     a88  
 "Y888888P'  
END

%a<4> =q:to/END/;
        ,d8    
      ,d888    
    ,d8" 88    
  ,d8"   88    
,d8"     88    
8888888888888  
         88    
         88    
END

%a<5> =q:to/END/;
8888888888   
88           
88  ____     
88a8PPPP8b,  
PP"     `8b  
         d8  
Y8a     a8P  
 "Y88888P"   
END

%a<6> =q:to/END/;
  ad8888ba,  
 8P'    "Y8  
d8           
88,dd888bb,  
88P'    `8b  
88       d8  
88a     a8P  
 "Y88888P"   
END

%a<7> =q:to/END/;
888888888888  
        ,8P'  
       d8"    
     ,8P'     
    d8"       
  ,8P'        
 d8"          
8P'           
END

%a<8> =q:to/END/;
 ad88888ba   
d8"     "8b  
Y8a     a8P  
 "Y8aaa8P"   
 ,d8"""8b,   
d8"     "8b  
Y8a     a8P  
 "Y88888P"   
END

%a<9> =q:to/END/;
 ad88888ba   
d8"     "88  
8P       88  
Y8,    ,d88  
 "PPPPPP"88  
         8P  
8b,    a8P   
`"Y8888P'    
END

%a<:> =q:to/END/;
     
888  
888  
     
     
888  
888  
     
END

my %b;

for 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, ":" -> $id
{
  for %a{$id}.split("\n") -> $line
  {
    %b{$id}.push($line);
  }
}

loop
{
  shell 'clear';
  
  my @chars = DateTime.now.hh-mm-ss.comb;

  for 0 .. 7 -> $line
  {
    for @chars -> $char
    {
      print @(%b{$char})[$line];
    }
    say "";
  }

  sleep 1;
}
