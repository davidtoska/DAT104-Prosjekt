package utils;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;


public class LiveFeedbackUtil {
    
    private static final Integer ANTALL_MULIGE_TILBAKEMELDINGER = 3;

    private static final Integer ANTALL_DUMMY_TILBAKEMELDINGER = 150;
    
    private static final Integer ANTALL_SLOTTER = 20;
    
    public static Integer formaterTilbakemelding(Timestamp eventStart, 
            Timestamp tidTilbakemelding, Integer tilbakemelding){
        
        Long diffMillisekunder = tidTilbakemelding.getTime() - eventStart.getTime();
        Integer diffSekunder = Math.toIntExact(diffMillisekunder/1000);
        
        Integer minuttNummer = diffSekunder/60;
        System.out.println("minuttnummer: " + minuttNummer);
        
        Integer formatertTBM =  minuttNummer*ANTALL_MULIGE_TILBAKEMELDINGER + tilbakemelding;
        
        return formatertTBM;
    }
    

    public static List<Integer> hentDummyTilbakemeldinger(){
        List<Integer> tbm = new ArrayList<>();
        Random r = new Random();
        for(int i= 0; i < ANTALL_DUMMY_TILBAKEMELDINGER; i++){
            tbm.add(r.nextInt(ANTALL_SLOTTER * ANTALL_MULIGE_TILBAKEMELDINGER));
        }
        
        

        return tbm;
    }
    
    
    /**
     * Lager en frekvenstabel over alle tilbakemeldingene. Må oppgi hvor langt frekvenstabellen kan gå.
     * @param alleTilbakemeldinger
     * @param maxVerdi
     * @return 
     */
    public static List<Integer> lagFrekvensTabell(List<Integer> alleTilbakemeldinger, Integer maxVerdi){
        Integer[] ftb = new Integer[maxVerdi];
        
        for(int i = 0; i < maxVerdi; i++){
            ftb[i] = 0;
        }
        
        for(int i = 0; i < alleTilbakemeldinger.size(); i++){
            int denne = alleTilbakemeldinger.get(i);
            ftb[denne] += 1;
        }
        
        return Arrays.asList(ftb);
    }

}
