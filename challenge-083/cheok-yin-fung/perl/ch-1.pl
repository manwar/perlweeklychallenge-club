$_ = <STDIN>;
/(^\w+\s)([\w\s*]+)(\s\w+$)/;
$_ = $2;
s/\s//g;
print length, "\n";

