#! /usr/bin/env perl6

unit sub MAIN ($dictionary where $dictionary.IO.e && $dictionary.IO.r = "/usr/share/dict/british-english", :$all);

my %states = 
       "AK  Alaska           LA  Louisiana        OH  Ohio
        AL  Alabama          MA  Massachusetts    OK  Oklahoma
        AR  Arkansas         MD  Maryland         OR  Oregon
        AZ  Arizona          ME  Maine            PA  Pennsylvania
        CA  California       MI  Michigan         RI  Rhode Island
        CO  Colorado         MN  Minnesota        SC  South Carolina
        CT  Connecticut      MO  Missouri         SD  South Dakota
        DE  Delaware         MS  Mississippi      TN  Tennessee
        FL  Florida          MT  Montana          TX  Texas
        GA  Georgia          NC  North Carolina   UT  Utah
        HI  Hawaii           ND  North Dakota     VA  Virginia
        IA  Iowa             NE  Nebraska         VT  Vermont
        ID  Idaho            NH  New Hampshire    WA  Washington
        IL  Illinois         NJ  New Jersey       WI  Wisconsin
        IN  Indiana          NM  New Mexico       WV  West Virginia
        KS  Kansas           NV  Nevada           WY  Wyoming
        KY  Kentucky         NY  New York".split(/\s\s+/).hash;

sub get-dictionary ($file where $file.IO.r)
{
  return $file.IO.lines>>.uc.grep({ .chars %% 2 }).grep(* !~~ /\W/).unique.sort({ $^b.chars cmp $^a.chars }); # As "aß" ->  "ASS"
}

my $found = 0;

for get-dictionary($dictionary) -> $word
{ 
  last if $word.chars < $found;
  
  check-word($word);

  last if $found && !$all;
}

say "\nWord length: $found.";

sub check-word ($word)
{
  my @parts = $word.comb(2);

  return unless %states{$_} for @parts;
  
  say "{ @parts.map({ %states{$_} }).join(" + ") } = $word";
  
  $found = $word.chars; 
}


