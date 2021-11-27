/* Very rough JavaScript*/


document.write("<p>The Weekly Challenge Week 140</p>");
document.write("<p>Task 2 Multiplication Table</p>");
document.write("i: <input type=\"text\" placeholder=\"\" id=\"i\">");
document.write("<br>");
document.write("j: <input type=\"text\" placeholder=\"\" id=\"j\">");
document.write("<br>");
document.write("k: <input type=\"text\" placeholder=\"\" id=\"k\">");
document.write("<br>");


document.write("<button onclick=\"calc()\">Calculate</button>" );


function calc() {
    let i = parseInt(document.getElementById("i").value);
    let j = parseInt(document.getElementById("j").value);
    let k = parseInt(document.getElementById("k").value);

    if (isNaN(i) || isNaN(j) || isNaN(k)) {
        window.alert("Unable to parse integer. Terminate calculation.");
        return;
    }

    if (i*j<k) {
        window.alert("k > i*j. Terminate calculation.");
        return;
    }


    document.write("<p>" + "i: "+ i + ";j: " +j+";k: " + k + "." + "</p>");

    document.write("<table border=\"1\" style=\"text-align:right\">");

    let _arr = [];

    for (var _i = 1; _i <= i; _i++) {
        document.write("<tr>");
        for (var _j = 1; _j <= j; _j++) {
            document.write("<td>");
            document.write(_i*_j);
            _arr.push(_i*_j);
            document.write("</td>");
        }
        document.write("</tr>");
    }

    document.write("</table>");

    let arr = _arr.sort();

    document.write("<p> Answer: "+arr[k-1]+"</p>");


    return;
}


