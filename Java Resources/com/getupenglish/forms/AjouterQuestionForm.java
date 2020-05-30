package com.getupenglish.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.Question;
import com.getupenglish.dao.DAOException;
import com.getupenglish.dao.QuestionDao;

public class AjouterQuestionForm {
    private static final String CHAMP_ID_COURS    = "idCours";
    private static final String CHAMP_QUESTION    = "question";
    private static final String CHAMP_IMAGE       = "image";
    private static final String CHAMP_REPONSE     = "reponse";

    private static final String ATT_SESSION_COURS = "mapCours";

    private QuestionDao         questionDao;

    public AjouterQuestionForm( QuestionDao questionDao ) {
        this.questionDao = questionDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Question ajouterQuestion( HttpServletRequest request ) {
        String idCours = getValeurChamp( request, CHAMP_ID_COURS );

        String questionValeur = getValeurChamp( request, CHAMP_QUESTION );
        String image = getValeurChamp( request, CHAMP_IMAGE );
        String reponse = getValeurChamp( request, CHAMP_REPONSE );

        Question question = new Question();

        try {
            traiterQuestion( questionValeur, question );

            HttpSession session = request.getSession();
            Map<Long, Cours> mapCours = (Map<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );
            try {
                Cours cours = mapCours.get( Long.parseLong( idCours ) );
                question.setCours( cours );
            } catch ( NumberFormatException e ) {
                e.printStackTrace();
            }

            question.setReponse( reponse );

            question.setImage( image );

            if ( erreurs.isEmpty() ) {
                if ( question.getQuestion().endsWith( ";" ) ) {
                    question.setQuestion( question.getQuestion() + " " );
                } else if ( question.getQuestion().startsWith( ";" ) ) {
                    question.setQuestion( " " + question.getQuestion() );
                }
                questionDao.create( question );
                resultat = "Question ajouté avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'addition." );
            resultat = "Échec de la création de la question : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return question;
    }

    private void traiterQuestion( String questionValeur, Question question ) {
        try {
            validationQuestion( questionValeur );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_QUESTION, e.getMessage() );
        }
        question.setQuestion( questionValeur );
    }

    private void validationQuestion( String question ) throws FormValidationException {
        if ( question != null && question.length() < 10 ) {
            throw new FormValidationException( "La question du cours doit contenir au moins 10 caractères." );
        } else if ( question == null ) {
            throw new FormValidationException( "Merci de saisir la question." );
        } else if ( !question.contains( ";" ) ) {
            throw new FormValidationException( "Merci d'entrer le séparateur." );
        } else if ( question.length() - question.replace( ";", "" ).length() > 1 ) {
            throw new FormValidationException( "Merci d'entrer un seul séparateur." );
        }
    }

    private void setErreur( String champ, String message ) {
        erreurs.put( champ, message );
    }

    private static String getValeurChamp( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur.trim();
        }
    }
}
