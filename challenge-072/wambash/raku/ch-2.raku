use v6;

unit sub MAIN ($a, $b, $file);
$file.IO.lines.head($b).skip($a-1)».say
