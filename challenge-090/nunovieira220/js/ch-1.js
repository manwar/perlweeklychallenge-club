// Input
const sequence = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

// DNA Sequence
const convert = {'T': 'A', 'A': 'T', 'G': 'C', 'C': 'G'};
const counters = {'A': 0, 'C': 0, 'G': 0, 'T': 0};
let complementary = '';

sequence.split('').forEach(base => {
  counters[base]++;
  complementary += convert[base];
});

// Output
const { A, C, G, T } = counters;
console.log(`Adenine: ${A}`);
console.log(`Cytosine: ${C}`);
console.log(`Guanine: ${G}`);
console.log(`Thymine: ${T}`);
console.log(`Complementary: ${complementary}`);