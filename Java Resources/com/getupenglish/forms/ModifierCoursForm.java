package com.getupenglish.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.getupenglish.beans.Cours;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.DAOException;

public class ModifierCoursForm {
    private static final String CHAMP_TITRE      = "titre";
    private static final String CHAMP_CATEGORIE  = "categorie";
    private static final String CHAMP_DIFFICULTE = "difficulte";
    private static final String CHAMP_CONTENU    = "contenu";

    private CoursDao            coursDao;

    public ModifierCoursForm( CoursDao coursDao ) {
        this.coursDao = coursDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Cours modifierCours( HttpServletRequest request, Cours cours ) {
        String titre = getValeurChamp( request, CHAMP_TITRE );
        String categorie = getValeurChamp( request, CHAMP_CATEGORIE );
        String difficulte = getValeurChamp( request, CHAMP_DIFFICULTE );
        String contenu = getValeurChamp( request, CHAMP_CONTENU );

        try {
            traiterTitre( titre, cours );
            traiterContenu( contenu, cours );

            traiterCategorie( categorie, cours );
            traiterDifficulte( difficulte, cours );

            if ( erreurs.isEmpty() ) {
                coursDao.update( cours );
                resultat = "Cours n° : " + cours.getId() + " modifié avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de la modification." );
            resultat = "Échec de la modification du cours : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return cours;
    }

    private void traiterCategorie( String categorie, Cours cours ) {
        String stringCategorie = "";
        try {
            stringCategorie = validationCategorie( categorie );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_CATEGORIE, e.getMessage() );
        }
        cours.setCategorie( stringCategorie );
    }

    private void traiterDifficulte( String difficulteString, Cours cours ) {
        int difficulte = -1;
        try {
            difficulte = validationDifficulte( difficulteString );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_CATEGORIE, e.getMessage() );
        }
        cours.setDifficulte( difficulte );
    }

    private void traiterTitre( String titre, Cours cours ) {
        try {
            validationTitre( titre );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_TITRE, e.getMessage() );
        }
        cours.setTitre( titre );
    }

    private void traiterContenu( String contenu, Cours cours ) {
        try {
            validationContenu( contenu );
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_CONTENU, e.getMessage() );
        }
        cours.setContenu( contenu );
    }

    private String validationCategorie( String categorie ) throws FormValidationException {
        String valeur;
        if ( categorie != null ) {
            switch ( categorie ) {
            case "1":
                valeur = "Grammaire";
                break;
            case "2":
                valeur = "Orthographe";
                break;
            case "3":
                valeur = "Vocabulaire et Lexique";
                break;
            default:
                throw new FormValidationException( "Merci de sélectionner une categorie valide." );
            }
        } else {
            valeur = "";
            throw new FormValidationException( "Merci de sélectionner la categorie." );
        }
        return valeur;
    }

    private int validationDifficulte( String difficulteString ) throws FormValidationException {
        int temp;
        if ( difficulteString != null ) {
            switch ( difficulteString ) {
            case "1":
                temp = 1;
                break;
            case "2":
                temp = 2;
                break;
            case "3":
                temp = 3;
                break;
            default:
                throw new FormValidationException( "Merci de sélectionner une difficulté valide." );
            }
        } else {
            temp = 1;
            throw new FormValidationException( "Merci de sélectionner la difficulté." );
        }
        return temp;
    }

    private void validationTitre( String titre ) throws FormValidationException {
        if ( titre != null && titre.length() < 5 ) {
            throw new FormValidationException( "Le titre du cours doit contenir au moins 5 caractères." );
        } else if ( titre == null ) {
            throw new FormValidationException( "Merci de saisir le titre du cours." );
        }
    }

    private void validationContenu( String contenu ) throws FormValidationException {
        if ( contenu != null && contenu.length() < 10 ) {
            throw new FormValidationException( "Le contenu doit contenir au moins 10 caractères." );
        } else if ( contenu == null ) {
            throw new FormValidationException( "Merci de saisir le contenu." );
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
