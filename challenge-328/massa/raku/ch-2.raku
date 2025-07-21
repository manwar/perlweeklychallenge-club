1 while s/(<:Lu>)(<:Ll>) <?{$0 eq $1.uc}>// | s/(<:Ll>)(<:Lu>) <?{$0 eq $1.lc}>//
