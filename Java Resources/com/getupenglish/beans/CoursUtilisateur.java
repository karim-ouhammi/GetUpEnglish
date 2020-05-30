package com.getupenglish.beans;

public class CoursUtilisateur {
    private Cours       cours;
    private Utilisateur utilisateur;
    private Double      note;

    public Cours getCours() {
        return cours;
    }

    public void setCours( Cours cours ) {
        this.cours = cours;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur( Utilisateur utilisateur ) {
        this.utilisateur = utilisateur;
    }

    public Double getNote() {
        return note;
    }

    public void setNote( Double note ) {
        this.note = note;
    }
}
