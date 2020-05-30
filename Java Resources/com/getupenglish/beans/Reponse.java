package com.getupenglish.beans;

public class Reponse {
    private Long   id;
    private Cours  cours;
    private String reponse;

    public Reponse() {
        super();
    }

    public Reponse( Cours cours, String reponse ) {
        this.cours = cours;
        this.reponse = reponse;
    }

    public Long getId() {
        return id;
    }

    public void setId( Long id ) {
        this.id = id;
    }

    public Cours getCours() {
        return cours;
    }

    public void setCours( Cours cours ) {
        this.cours = cours;
    }

    public String getReponse() {
        return reponse;
    }

    public void setReponse( String reponse ) {
        this.reponse = reponse;
    }
}
