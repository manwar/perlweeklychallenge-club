(module
  (func $left_factorial (export "left_factorial") (param $n i32) (result i32)
    (local $acc_left i32)
    (local $acc_fact i32)
    (local $count    i32)

    ;; If $n < 1, return 1, else return the result of the loop.
    (i32.lt_s (get_local $n) (i32.const 1))
    if (result i32)
      i32.const 1
    else
      (set_local $count    (i32.const  0)) ;; $count     = 0
      (set_local $acc_left (i32.const  1)) ;; $acc_left  = 1
      (set_local $acc_fact (i32.const  1)) ;; $acc_fact  = 1

      (loop $accumulate
        (set_local $count     (i32.add (get_local $count     ) (i32.const 1         ))) ;; $count    += 1
        (set_local $acc_fact  (i32.mul (get_local $acc_fact  ) (get_local $count    ))) ;; $acc_fact *= $count
        (set_local $acc_left  (i32.add (get_local $acc_left  ) (get_local $acc_fact ))) ;; $acc_left += $acc_fact

        (br_if $accumulate (i32.lt_s (get_local $count) (get_local $n)))                ;; loop if $count < $n
      )

      get_local $acc_left    ;; return $acc_left
    end
  )
)
;; To test, go to https://webassembly.github.io/wabt/demo/wat2wasm/ ,
;; copy the code above to the WAT window (top-left),
;; and  the code below to the JS  window (bottom-left).
;; Output will be in the JS LOG   window (bottom-right).
const wasmInstance = new WebAssembly.Instance(wasmModule, {});
const { left_factorial } = wasmInstance.exports;
console.log([...Array(10+1).keys()].map(left_factorial).join(', '));
// Output is: 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114, 4037914
