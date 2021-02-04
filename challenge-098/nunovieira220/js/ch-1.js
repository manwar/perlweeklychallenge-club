// Read N-characters
const readN = async (F, N) => {
  const buffer = new Buffer.alloc(1024);
  const fh = await require('fs').promises.open(F, 'r+');

  await fh.read(buffer, 0, N, 0);
  await fh.close(); // Close file handler

  return buffer.toString();
}

// Input
const F = "input.txt";
const N = 4;

// Output
(async () => console.log(await readN(F, N)))();
