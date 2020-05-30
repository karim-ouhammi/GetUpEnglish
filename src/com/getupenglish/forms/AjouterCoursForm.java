package com.getupenglish.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.joda.time.DateTime;

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.Reponse;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.DAOException;
import com.getupenglish.dao.ReponseDao;

public class AjouterCoursForm {
    private static final String CHAMP_TITRE              = "titre";
    private static final String CHAMP_CATEGORIE          = "categorie";
    private static final String CHAMP_DIFFICULTE         = "difficulte";
    private static final String CHAMP_CONTENU            = "contenu";

    private static final String CHAMP_EXISTANCE_REPONSES = "existanceDesExercices";
    private static final String CHAMP_REPONSES           = "reponses";
    private static final String PAS_REPONSES             = "pasReponses";

    private static final String ATT_SESSION_REPONSE      = "reponses";

    private CoursDao            coursDao;
    private ReponseDao          reponseDao;

    public AjouterCoursForm( CoursDao coursDao, ReponseDao reponseDao ) {
        this.coursDao = coursDao;
        this.reponseDao = reponseDao;
    }

    private String              resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() {
        return resultat;
    }

    public Map<String, String> getErreurs() {
        return erreurs;
    }

    public Cours ajouterCours( HttpServletRequest request ) {
        String existanceDesExercices = getValeurChamp( request, CHAMP_EXISTANCE_REPONSES );

        String titre = getValeurChamp( request, CHAMP_TITRE );
        String categorie = getValeurChamp( request, CHAMP_CATEGORIE );
        String difficulte = getValeurChamp( request, CHAMP_DIFFICULTE );
        String contenu = getValeurChamp( request, CHAMP_CONTENU );

        DateTime dt = new DateTime();
        Cours cours = new Cours();

        String[] reponses;

        try {
            traiterTitre( titre, cours );
            traiterContenu( contenu, cours );

            traiterCategorie( categorie, cours );
            traiterDifficulte( difficulte, cours );

            /*
             * Si l'admin n'ajout pas des réponses, pas de validation à
             * effectuer
             */
            if ( PAS_REPONSES.equals( existanceDesExercices ) ) {
                reponses = null;
            } else {
                /*
                 * Sinon on recupere les réponses pour les valider.
                 */
                reponses = traiterReponses( getValeurChamp( request, CHAMP_REPONSES ) );
            }

            cours.setDate( dt );

            if ( erreurs.isEmpty() ) {
                coursDao.create( cours );

                if ( reponses != null ) {
                    for ( String reponse : reponses ) {
                        Reponse rep = new Reponse();
                        rep.setCours( cours );
                        rep.setReponse( reponse.trim().toLowerCase() );
                        reponseDao.create( rep );

                        HttpSession session = request.getSession();
                        Map<Long, Reponse> mapReponses = (HashMap<Long, Reponse>) session
                                .getAttribute( ATT_SESSION_REPONSE );

                        if ( mapReponses == null ) {
                            mapReponses = new HashMap<Long, Reponse>();
                        }
                        mapReponses.put( rep.getId(), rep );

                        session.setAttribute( ATT_SESSION_REPONSE, mapReponses );
                    }
                }
                resultat = "Cours ajouté avec succès.";
            } else {
                resultat = "Échec de l'operation.";
            }
        } catch ( DAOException e ) {
            setErreur( "imprévu ", "Erreur imprévue lors de l'addition." );
            resultat = "Échec de la création du cours : une erreur imprévue est survenue, merci de réessayer dans quelques instants.";
            e.printStackTrace();
        }

        return cours;
    }

    private String[] traiterReponses( String stringReponses ) {
        try {
            String[] array = validationReponses( stringReponses );
            return array;
        } catch ( FormValidationException e ) {
            setErreur( CHAMP_REPONSES, e.getMessage() );
        }
        return null;
    }

    private String[] validationReponses( String stringReponses ) throws FormValidationException {
        if ( stringReponses == null ) {
            throw new FormValidationException( "Merci de saisir les réponses." );
        } else {
            String[] array = stringReponses.split( ";" );
            if ( array.length == 1 ) {
                throw new FormValidationException( "Merci de saisir deux réponses au minimum." );
            }
            return array;
        }
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
