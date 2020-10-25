$_ = <STDIN>;
/(^\w+\s)((\w+\s*)+)(\s\w+$)/;
print length $2,"\n";

