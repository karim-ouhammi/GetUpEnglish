package com.getupenglish.beans;

import org.joda.time.DateTime;

public class Cours {
    private Long     id;
    private String   categorie;
    private String   titre;
    private String   contenu;
    private int      difficulte;
    private DateTime date;

    public Long getId() {
        return id;
    }

    public void setId( Long id ) {
        this.id = id;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie( String categorie ) {
        this.categorie = categorie;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre( String titre ) {
        this.titre = titre;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu( String contenu ) {
        this.contenu = contenu;
    }

    public int getDifficulte() {
        return difficulte;
    }

    public void setDifficulte( int difficulte ) {
        this.difficulte = difficulte;
    }

    public DateTime getDate() {
        return date;
    }

    public void setDate( DateTime date ) {
        this.date = date;
    }
}
