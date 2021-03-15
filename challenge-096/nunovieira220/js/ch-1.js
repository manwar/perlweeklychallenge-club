// Input
const S = '    Perl and   Raku are  part of the same family  ';

// Reverse Words
const trimmed = S.trim().replace(/\s+/g, ' ');
const res = trimmed.split(' ').reverse().join(' ');

// Output
console.log(res);