(module
  (func $is_factorion (export "is_factorion") (param $n i32) (result i32)
    ;; Well-known sequence; The 4 known terms are the only terms possible. See https://oeis.org/A014080
    (i32.or
      (i32.or (i32.eq (get_local $n) (i32.const     1))
              (i32.eq (get_local $n) (i32.const     2)) )
      (i32.or (i32.eq (get_local $n) (i32.const   145))
              (i32.eq (get_local $n) (i32.const 40585)) )
    )
  )
)
;; To test, go to https://webassembly.github.io/wabt/demo/wat2wasm/ ,
;; copy the code above to the WAT window (top-left),
;; and  the code below to the JS  window (bottom-left).
;; Output will be in the JS LOG   window (bottom-right).
const wasmInstance = new WebAssembly.Instance(wasmModule, {});
const { is_factorion } = wasmInstance.exports;
console.log(                    [145,123].map(is_factorion).join(', '));
console.log([...Array(2000000).keys()].filter(is_factorion).join(', '));
// Output is:
//    1, 0
//    1, 2, 145, 40585
