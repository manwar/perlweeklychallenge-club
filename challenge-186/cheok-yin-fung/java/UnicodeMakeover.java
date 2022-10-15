// The Weekly Challenge 186
// Task 2 Unicode Makeover
// Java Solution

import java.text.Normalizer;
// Please also take a look at: java.lang.Character;

public class UnicodeMakeover
{
    public static void main(String[] args) {
        System.out.println(makeover("ÃÊÍÒÙ"));
        System.out.println(makeover("âÊíÒÙ"));
        System.out.println(makeover("chữ Quốc ngữ"));
        System.out.println(makeover("Paul Erdős"));
        System.out.println(makeover("香港")); // no output
    }

    public static String makeover(String text)
    {
        StringBuilder aaa = new
            StringBuilder(Normalizer.normalize(text, Normalizer.Form.NFKD));
        String bbb = "";
        for (int i = 0; i < aaa.length(); i++)
        {
            if (aaa.codePointAt(i) <= 127)
            bbb += aaa.charAt(i);
        }
        return bbb;
    }
}
