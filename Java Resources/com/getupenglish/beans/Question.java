package com.getupenglish.beans;

public class Question {
    private Long   id;
    private Cours  cours;
    private String question;
    private String reponse;
    private String image;

    public String getImage() {
        return image;
    }

    public void setImage( String image ) {
        this.image = image;
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

    public String getQuestion() {
        return question;
    }

    public void setQuestion( String question ) {
        this.question = question;
    }

    public String getReponse() {
        return reponse;
    }

    public void setReponse( String reponse ) {
        this.reponse = reponse;
    }
}
