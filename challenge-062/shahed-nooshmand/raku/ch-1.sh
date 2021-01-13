raku -e '.key.put for <name@example.org rjt@cpan.org Name@example.org rjt@CPAN.org user@alpha.example.org>.map({/(.+) "@" (.+)/; $_ => [$1.fc, ~$0]}).sort(*.value)'
