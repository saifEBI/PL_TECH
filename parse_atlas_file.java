import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;
import org.apache.commons.collections4.list.SetUniqueList;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;

public class parse_atlas_file {

    static Multimap gene_tisse= ArrayListMultimap.create();
    static SetUniqueList tissues;
    static SetUniqueList genes;

    static Logger theLog=Logger.getLogger("Parser");


    public static void main(String args[])
    {


        try
        {
            BufferedReader br=new BufferedReader(new FileReader(new File (args[0])));

            //theLog.info("Opening file "+args[0]);

            String line=null;

            ArrayList temp_genes=new ArrayList();
            ArrayList temp_tissues=new ArrayList();


           LINES:  while((line=br.readLine())!=null)
            {
                if (line.isEmpty())
                {continue LINES;}
                String words[]=line.split("\t");
                temp_genes.add(words[0].trim());
                temp_tissues.add(words[1].trim());

                gene_tisse.put(words[0].trim()+"--"+words[1].trim(),words[2].trim());

            }

            genes=SetUniqueList.setUniqueList(temp_genes);
            tissues=SetUniqueList.setUniqueList(temp_tissues);



            printMatrix(genes,tissues,gene_tisse);
        }

        catch(IOException ioe){ioe.printStackTrace();}

    }



    private static void printMatrix(SetUniqueList genes, SetUniqueList tissues, Multimap gene_tisse) {

        Iterator i=genes.iterator();
        Iterator j =tissues.iterator();

        TreeMap colIndex=new TreeMap();
        TreeMap rowIndex=new TreeMap();
         int index=1;
        p("\t"); // Empty space for corner
        while (j.hasNext())
        {
            String tissue= (String) j.next();
            p(tissue+"\t");
            colIndex.put(index,tissue);
            index++;
        }
        pl("");

        while(i.hasNext())
        {

            String gene= (String) i.next();
            p(gene+"\t");
            j =tissues.iterator();
            while(j.hasNext())
            {
                String tissue= (String) j.next();

                Collection<String> counts = gene_tisse.get(gene+"--"+tissue);


                //ArrayList counts
                      // = (ArrayList) gene_tisse.get(gene+"--"+tissue);

               int meanCounts=collateCounts(counts);
               p(meanCounts+"\t");


            }

            pl(""); //newLine




        }




    }

    private static int collateCounts(Collection<String> a) {

        Iterator i=a.iterator();
        int total=0;
        int index=0;

        while(i.hasNext())
        {
            String x= (String) i.next();
            Integer num=Integer.parseInt(x);
            total+=num;
            index++;
        }

        if(index==0)
        {
            return 0;
        }

        return(total/index);

    }


    public static void pl(String arg)
    {
        System.out.println(arg);
    }


    public static void p(String arg)
    {
        System.out.print(arg);
    }

}
