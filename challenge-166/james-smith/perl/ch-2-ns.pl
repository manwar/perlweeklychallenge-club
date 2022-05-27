(@_=split'/'),push@{$d{$_[0]}},-d?"$_[1]/":$_[1]for<*/*>;$u{$_}++for map{@{$d{$_}}}my@p=sort keys%d;$l<length?$l=length:1for@p,@_=keys%u;print$H=join('-'x($l+2),('+')x@p,'+
'),sprintf($T="| %-${l}s "x@p.'|
',@p),$H,map({$u{$F=$_}<@p?sprintf$T,map{$d{$_}[0]ne$F?'':shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort@_),$H