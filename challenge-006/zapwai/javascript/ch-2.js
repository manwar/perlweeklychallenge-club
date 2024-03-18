Decimal.set({ precision: 35 });
const x = new Decimal("163");
const pi = new Decimal("3.141592653589793238462643383279502884197169");
const r = pi.times(x.sqrt());
const e = new Decimal("2.7182818284590452353602874713526624977572");
const result = e.pow(r);
console.log(result.toString());

// Add this line to the html file to include the Decimal library:
// <script src="https://cdnjs.cloudflare.com/ajax/libs/decimal.js/10.3.1/decimal.min.js"></script>
