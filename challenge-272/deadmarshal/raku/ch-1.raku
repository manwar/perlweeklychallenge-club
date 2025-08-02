#!/usr/bin/env raku

sub defrag-ip-address($str)
{
  $str.subst('.','[.]',:g)
}

say defrag-ip-address('1.1.1.1');
say defrag-ip-address('255.101.1.0');

