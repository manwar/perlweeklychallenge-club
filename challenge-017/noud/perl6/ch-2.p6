# Create a script to parse URL and print the components of URL. According to Wiki page, the URL syntax is as below:
#
#        scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#
# For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
#
#          scheme:   jdbc:mysql
#          userinfo: user:password
#          host:     localhost
#          port:     3306
#          path:     /pwc
#          query:    profile=true
#          fragment: h1

sub parse($url) {
    my @keys = <scheme userinfo host port path query fragment>;
    my $reg = / (\w+\:\w+)\:\/\/(\w+\:.+)\@(\w+)\:(\d+)(\/\w+)\?(.+)\#(\w+)$ /;

    return Hash.new(@keys Z ($url ~~ $reg).values);
}


multi MAIN('test') {
    use Test;

    is parse("jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1"),
        {
            scheme => "jdbc:mysql",
            userinfo => "user:password",
            host => "localhost",
            port => 3306,
            path => "/pwc",
            query => "profile=true",
            fragment => "h1"
        };
}

