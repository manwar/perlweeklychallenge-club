sub MAIN($W,$B){
my@w=$W.IO.lines;
my@b=$B.IO.slurp.subst(' ',:g).lines;
my$w=@b[0].chars;
my@c=@b.map(|*.comb);
sub f($t){$t~"~"~$t.flip~~m:ex:i/@w/}
multi r{@c.batch($w),|((0,0),(0,1),(1,0)).map(&r)}
multi r($o){(^$w).map({@c[$_+$o[0],($_+$w+$o[1])...*]})}
.say for f r.flat.join}