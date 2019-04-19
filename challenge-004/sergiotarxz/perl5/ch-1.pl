use Math::BigFloat;
open$fh,'<',$0;
$b+=scalar(split//,$_)while (<$fh>);
print Math::BigFloat->bpi($b)."\n";
