#! /usr/bin/env node

var N = process.argv[2] || 3;

var verbose = false;

if (N == '--verbose') 
{
  verbose = true;
  N = process.argv[3] || 3;
}

let die = (message) => {
    console.log(message);
    process.kill(process.pid);
};

var NN = parseInt(N);

if (NN != N || NN < 2 || NN > 5)
    die('N: Integer 2,3,4,5 only');

var sequence = [0,1,3,2];

let asBinary = (value, length) => {
  var binary =  value.toString(2);

  while (binary.length < length)
    binary = "0" + binary;

  return binary;
}

let generate2bgcs = (array, level) => {
  var S1a = array.map(x => asBinary(x,level-1) );
  var S2a = S1a.slice(); S2a.reverse();
  var S1  = S1a.map(x => '0' + x);
  var S2  = S2a.map(x => '1' + x);
  var S3  = S1; for (x of S2) { S3.push(x); }
  var out = S3.map( x => parseInt(x, 2) );
  
  if (verbose)
  {
    console.log(': in: ' + array);
    console.log(': a) S1 = ' + S1a);
    console.log(': b) S2 = ' + S2a);
    console.log(': c) S1 = ' + S1);
    console.log(': d) S2 = ' + S2);
    console.log(': e) S3 = ' + S3);
    console.log(': out: ' + out);
  }

  return out;
}

for (level = 3; level <= NN; level++)
{
  sequence = generate2bgcs(sequence, level);
}

console.log(sequence);

