#!/usr/bin/env raku

sub canonical-path ( $path ) {
    my IO::Path $clean-path = $path.IO.cleanup;
    with $clean-path.resolve(:completely) {
        .path
    } orwith $clean-path.path {
        $_, *.subst(/'/'<-[/]>*'/..'/, '') ... * eq *
        andthen .tail || '/'
    }
}


multi MAIN ($path) {
    say canonical-path $path
}

multi MAIN (:test($)! ) {
    use Test;
    is canonical-path("/a/"), "/a";
    is canonical-path("/a/b//c/"), "/a/b/c";
    is canonical-path("/a/b/c/../.."), "/a";
    is canonical-path('/var//./../var/../log/apache-flink/../..'), '/';
    is canonical-path('/var//./../var/log/apache-flink/..'), '/var/log';
    done-testing;
}
