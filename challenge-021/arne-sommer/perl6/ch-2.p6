#! /usr/bin/env perl6

grammar URL
{
  regex TOP       { <SchemeW> <Hostinfo>? <Path>? <QueryW>? <FragmentW>? }
  regex SchemeW   { <Scheme> <SchemeS> }
  regex SchemeS   { ':' }
  regex Scheme    { <[a..z A..Z]><[a..z A..Z 0..9 + . : \-]>* }
  regex Hostinfo  { '//' <UserinfoW>? <Host> <PortW>? }
  regex UserinfoW { <Userinfo> <UserinfoS> }
  regex Userinfo  { .*[\:.+]? }
  regex UserinfoS { '@' }
  regex Host      { <[\w \. \-]>* }
  regex PortW     { <PortS> <Port> }
  regex PortS     { ':' }
  regex Port      { \d+ }
  regex Path      { '/'? <[\w \d / % \. - ] - [#?]>+ }
  regex QueryW    { <QueryS> <Query> }
  regex QueryS    { '?'  }
  regex Query     { <[\w \d \- =]>* }
  regex FragmentW { <FragmentS> <Fragment> }
  regex FragmentS { '#' }
  regex Fragment  { .+ }
}

sub MAIN ($url, :$verbose)
{
  my %ports = ( ftp => 20, http => 80, https => 443 );
  my Set $unreserved = ("41" ... "49", "4A" ... "4F", "50" ... "59", "5A", "30" ... "39", "2D", "2E", "5F", "7E").flat.Set;

  my %translate; %translate{'%' ~ $_} = chr( $_.parse-base(16) ) for $unreserved.keys;

  my $result = URL.parse($url);

  if $result
  {
    say $result, "\n" if $verbose;
    
    my $scheme = $result<SchemeW><Scheme>.lc;
    my $new    = $scheme ~ ":";
    say "scheme:   $result<SchemeW><Scheme> -> $scheme" if $verbose;

    my $userinfo = ""; if $result<Hostinfo><UserinfoW><Userinfo>
    {
      $userinfo = $result<Hostinfo><UserinfoW><Userinfo>;
      $new ~= $userinfo ~ '@';
      say "userinfo: $userinfo" if $verbose;
    }

    my $host = ""; if $result<Hostinfo><Host>
    {
      $host = $result<Hostinfo><Host>.lc;
      $new ~= "//$host" if $host;
      say "host:     $result<Hostinfo><Host> -> $host" if $verbose;
    }

    my $port = ""; if $result<Hostinfo><PortW><Port>
    {
      $port = $result<Hostinfo><PortW><Port> unless %ports{$scheme} == $result<Hostinfo><PortW><Port>;
      $new ~= ":$port" if $port;
      say "port:     $result<Hostinfo><PortW><Port> -> $port" if $verbose;
    }

    my $path = ""; if $result<Path>
    {
      $path = $result<Path>;
      my $new-path = $path;
      
      if $path ~~ /\%/
      {   
        $new-path .= subst(/\%../, *.uc, :g);

        for %translate.keys -> $key
	{
	  if $new-path ~~ /$key/
	  {
	    say "          (path translate $key -> %translate{$key})" if $verbose;
            $new-path .= subst($key, %translate{$key}, :g);
          }
        }
      }
      $new ~= $new-path;
      say "path:     $path -> $new-path" if $verbose;
    }

    my $query; if $result<QueryW><Query>
    {
      $query = $result<QueryW><Query>;
      $new ~= "?$query";
      say "query:    $query" if $verbose;
    }

    my $fragment = ""; if $result<FragmentW><Fragment>
    {
      $fragment = $result<FragmentW><Fragment>;
      $new ~= "#$fragment";
      say "fragment: $fragment" if $verbose;
    }

    print "\n" if $verbose;
    
    say "Original: $url";
    say "New:      $new";
  }
  else
  {
    say "Invalid URL.";
  }
}
