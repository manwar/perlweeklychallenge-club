#!/usr/bin/env perl6
#
grammar URI {
	token TOP {<scheme>\:<authority>?<path>[\?<query>]?[\#<fragment>]?};##|<authority>};
	token scheme { :i(<alpha>[<[\-\.\+] + alnum>]*)};
	token path { (\/<alpha>*)+};
	token authority { (\/\/)[<user>[\:<password>]?\@]?<host>[\:<port>]?};
	token user { (<alnum>+)};
	token password { ( <alnum> +)};

	token host { (<alnum>+)};
	token port { (<alnum>+)};
	token query { <qpair>[\&<qpair>]*};
	token qpair { (<qkey>\=<qval>)+};
	token qkey {<alnum>+};
	token qval {<alnum>+};
	token fragment { (<alnum>+)};
	##token query { \?<alpha>+};
	##token fragment { <alpha>+ };
}
	##|(<authority><path>)<query>?<fragment>?};


#say URI.parse("jdbc://user:password@localhost:3306/pwc?profile=true#h1");
my $m=URI.parse(@*ARGS[0]);
die "Not a URI\n" unless $m;
#say $m;
given $m {
	put "Scheme: {.<scheme>}";
	given .<authority> {
		put "User: {.<user>}";
		put "Password: {.<password>//""}";
		put "Host: {.<host>}";
		put "Port: {.<port>//""}";
	}
	put "Path: {.<path>//""}";
	put "Query: {.<query>//""}";
	put "Fragment: {.<fragment>//""}";
	
}
