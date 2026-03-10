public class ch_2 {
    public static void main(String[] args) {
        String[] paths = {"/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e"};
        String separator = "/";

        String[] common = null;

        for (String path : paths) {
            String[] parts = path.split(separator, -1);

            if (common == null) {
                common = parts;
            } else {
                int i = 0;
                while (i < common.length && i < parts.length && common[i].equals(parts[i])) {
                    i++;
                }
                String[] trimmed = new String[i];
                System.arraycopy(common, 0, trimmed, 0, i);
                common = trimmed;
            }
        }

        String result;
        if (common == null || common.length == 0) {
            result = "";
        } else {
            result = String.join(separator, common);
        }

        System.out.println("The common directory path is: " + result);
    }
}
