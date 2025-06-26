sub f {
    my %hash = map { $_ => 1 } @_;
    grep !exists $hash{$_}, 1 .. @_
}

print pop(@$_) eq join(',',f( @$_ )) ? "ok\n" : "err\n" for [1,2,1,3,2,5,'4,6'], [1,1,1,'2,3'], [2,2,1,'3'];
