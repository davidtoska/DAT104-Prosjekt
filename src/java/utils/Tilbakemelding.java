/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.util.ArrayList;
import java.util.List;

public class Tilbakemelding {
    
    
    
    private final List<Integer> liveTilbakemeldinger = new ArrayList<>();
    
    public void leggTilLiveTilbakemelding(Integer tilbakemelding){
        liveTilbakemeldinger.add(tilbakemelding);
    }

    public List<Integer> getLiveTilbakemeldinger() {
        return liveTilbakemeldinger;
    }
    
    
}
