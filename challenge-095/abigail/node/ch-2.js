let stack = [];
let ERROR = "Stack is empty";

  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.

. map          (command => {
    //
    // Parse the input line
    //
    let [m, operator, value] = command . match (/^(push|pop|top|min)\s*(.*)$/);

    //
    // Do the actions
    //
    if (operator == "push") {stack . push (+value)}
    if (operator == "pop")  {stack . pop ()}
    if (operator == "top")  {
        console . log (stack . length ? stack [stack . length - 1] : ERROR)
    }
    if (operator == "min")  {
        console . log (stack . length ? Math  . min (... stack)    : ERROR)
    }
});
