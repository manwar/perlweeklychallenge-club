sub no-connection(@routes) {
	(@routes»[1] ∖ @routes»[0]).keys.head
}

say no-connection [["B", "C"], ["D", "B"], ["C", "A"]];
say no-connection [["A", "Z"],];
