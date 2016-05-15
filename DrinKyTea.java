import com.phontron.kytea.*;

public class DrinKyTea
{
    static {
        try {
            System.loadLibrary("KyTeaPot");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Cannot load the example native code.\nMake sure your LD_LIBRARY_PATH contains \'.\'\n" + e);
            System.exit(1);
        }
    }

    private static void printWordInfoVector(WordInfoVector wordInfoVector)
    {
        for (int i = 0; i < wordInfoVector.size(); i++) {
            StringBuilder sb = new StringBuilder();

            WordInfo wordInfo = wordInfoVector.get(i);
            String surface = wordInfo.getSurface();
            sb.append(surface);
            ScoredTagsVector tagsList = wordInfo.getTags();
            for (int j = 0; j < tagsList.size(); j++) {
                ScoredTags tags = tagsList.get(j);
                for (int k = 0; k < tags.size(); k++) {
                    ScoredTag tag = tags.get(k);
                    sb.append("\t/ ");
                    sb.append(tag.getTag());
                    sb.append(" = ");
                    sb.append(tag.getScore());
                }
            }

            System.out.println(sb.toString());
        }
    }

    public static void main(String[] argv)
    {
    	KyTeaPot kyTeaPot = new KyTeaPot();
        printWordInfoVector(kyTeaPot.getWordInfoVector("10日放送の「中居正広のミになる図書館」（テレビ朝日系）で、SMAPの中居正広が、篠原信一の過去の勘違いを明かす一幕があった。"));
        System.out.println();
        printWordInfoVector(kyTeaPot.getWordInfoVector("すもももももももものうち"));
        System.out.println();
        printWordInfoVector(kyTeaPot.getWordInfoVector("太郎はこの本を二郎を見た女性に渡した。"));
    }
}

