package com.getupenglish.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.CoursUtilisateur;
import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;
import com.getupenglish.beans.Stats;
import com.getupenglish.beans.Utilisateur;
import com.getupenglish.dao.CoursUtilisateurDao;
import com.getupenglish.dao.DAOFactory;

@WebServlet( "/correction" )
public class Correction extends HttpServlet {
    private static final String CONF_DAO_FACTORY              = "daoFactory";

    private static final String VUE                           = "/WEB-INF/correction.jsp";
    private static final String VUE_GET                       = "/cours.jsp";

    private static final String ATT_SESSION_COURS             = "mapCours";
    private static final String ATT_SESSION_REPONSE           = "reponses";
    private static final String ATT_SESSION_QUESTION          = "questions";

    private static final String ATT_SESSION_USER              = "sessionUtilisateur";

    private static final String ATT_SESSION_COURS_UTILISATEUR = "coursUtilisateurs";

    private static final String ATT_COURS                     = "cours";
    private static final String ATT_LISTE_REPONSE             = "listeReponses";
    private static final String ATT_LISTE_QUESTION            = "listeQuestions";
    private static final String ATT_REPONSE_UTILISATEUR       = "reponsesUtilisateur";
    private static final String ATT_COURS_UTILISATEUR         = "coursUtilisateur";
    private static final String ATT_STATS                     = "stats";

    private static final String CHAMP_ID_COURS                = "idCours";
    private static final String CHAMP_ID_QUESTION             = "_idQuestion";

    private CoursUtilisateurDao coursUtilisateurDao;

    public void init() throws ServletException {
        this.coursUtilisateurDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getCoursUtilisateurDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher( VUE_GET ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // CoursUtilisateur
        Map<Long, List<CoursUtilisateur>> mapCoursUtilisateur = (HashMap<Long, List<CoursUtilisateur>>) session
                .getAttribute( ATT_SESSION_COURS_UTILISATEUR );

        // User
        Utilisateur utilisateur = (Utilisateur) session.getAttribute( ATT_SESSION_USER );

        // Cours, Reponses & Question
        Map<Long, Cours> mapCours = (Map<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );
        Map<Long, Reponse> reponses = (Map<Long, Reponse>) session
                .getAttribute( ATT_SESSION_REPONSE );
        Map<Long, Question> questions = (Map<Long, Question>) session
                .getAttribute( ATT_SESSION_QUESTION );

        // Listes
        List<Reponse> listeReponses = new ArrayList<Reponse>();
        List<Question> listeQuestions = new ArrayList<Question>();

        // idCours & Cours
        Long id = null;
        Cours cours = null;

        // Pour la correction
        Integer i = 1;
        String reponse = request.getParameter( i.toString() );
        Double note = 0.0;
        int nombreDesQuestions = 0;
        int reponseJuste = 0;
        Map<Long, String> reponsesUtilisateur = new HashMap<Long, String>();

        // Pour les Statistiques
        Stats stats = new Stats();
        int nombreParticipants = 0;
        Double sommeNotes = 0.0;
        int nombrePourcentage0_4 = 0;
        int nombrePourcentage5_9 = 0;
        int nombrePourcentage10_14 = 0;
        int nombrePourcentage15_19 = 0;
        int nombrePourcentage20 = 0;

        // Instance coursUtilisateurs
        CoursUtilisateur coursUtilisateur = new CoursUtilisateur();

        // Boolean pour verifier si on doit faire une mise a jour ou creation
        boolean existe = false;

        // Recuperations du cours
        String idCours = getValeurChamp( request, CHAMP_ID_COURS );
        try {
            id = Long.parseLong( idCours );
        } catch ( NumberFormatException ignore ) {
            ignore.printStackTrace();
        }
        if ( id != null && mapCours != null ) {
            cours = mapCours.get( id );
        }

        // Recuperations des listes
        if ( cours != null ) {
            for ( Map.Entry<Long, Reponse> entry : reponses.entrySet() ) {
                if ( entry.getValue().getCours().getId() == id ) {
                    listeReponses.add( entry.getValue() );
                }
            }
            for ( Map.Entry<Long, Question> entry : questions.entrySet() ) {
                if ( entry.getValue().getCours().getId() == id ) {
                    listeQuestions.add( entry.getValue() );
                }
            }
        }

        // Correction
        while ( reponse != null ) {
            nombreDesQuestions++;

            String idQUestion = getValeurChamp( request, i.toString() + CHAMP_ID_QUESTION );
            Question question = questions.get( Long.parseLong( idQUestion ) );

            if ( question.getReponse().equals( reponse ) ) {
                reponseJuste++;
            }

            reponsesUtilisateur.put( question.getId(), reponse );

            i++;
            reponse = request.getParameter( i.toString() );
        }
        try {
            note = reponseJuste * 20 * 1.0 / nombreDesQuestions;
        } catch ( ArithmeticException ignore ) {
        }

        // Remplissage de l'instance coursUtilisateur
        List<CoursUtilisateur> listeCoursUtlisateur = mapCoursUtilisateur.get( cours.getId() );

        coursUtilisateur.setCours( cours );
        coursUtilisateur.setNote( note );
        if ( utilisateur == null ) {
            coursUtilisateur.setUtilisateur( null );
        } else {
            coursUtilisateur.setUtilisateur( utilisateur );

            for ( int j = 0; j < listeCoursUtlisateur.size(); j++ ) {
                if ( listeCoursUtlisateur.get( j ).getCours().getId() == cours.getId() &&
                        listeCoursUtlisateur.get( j ).getUtilisateur().getEmail().equals( utilisateur.getEmail() ) ) {
                    existe = true;
                    listeCoursUtlisateur.set( j, coursUtilisateur );
                }

            }

            if ( existe ) {
                coursUtilisateurDao.update( coursUtilisateur );
            } else {
                coursUtilisateurDao.create( coursUtilisateur );
            }
        }

        // Mise a jour de la map CoursUtilisateur
        if ( !existe ) {
            listeCoursUtlisateur.add( coursUtilisateur );
        }
        mapCoursUtilisateur.put( cours.getId(), listeCoursUtlisateur );

        // Recuperations des Statistiques
        for ( CoursUtilisateur coursUser : listeCoursUtlisateur ) {
            nombreParticipants++;
            sommeNotes += coursUser.getNote();
            if ( coursUser.getNote() < 5 ) {
                nombrePourcentage0_4++;
            } else if ( coursUser.getNote() >= 5 && coursUser.getNote() < 10 ) {
                nombrePourcentage5_9++;
            } else if ( coursUser.getNote() >= 10 && coursUser.getNote() < 15 ) {
                nombrePourcentage10_14++;
            } else if ( coursUser.getNote() >= 15 && coursUser.getNote() < 20 ) {
                nombrePourcentage15_19++;
            } else if ( coursUser.getNote() == 20 ) {
                nombrePourcentage20++;
            }
        }
        stats.setNombreParticipants( nombreParticipants );
        stats.setMoyenne( sommeNotes / nombreParticipants );
        stats.setPourcentage0_4( ( nombrePourcentage0_4 * 1.0 / nombreParticipants ) * 100 );
        stats.setPourcentage5_9( ( nombrePourcentage5_9 * 1.0 / nombreParticipants ) * 100 );
        stats.setPourcentage10_14( ( nombrePourcentage10_14 * 1.0 / nombreParticipants ) * 100 );
        stats.setPourcentage15_19( ( nombrePourcentage15_19 * 1.0 / nombreParticipants ) * 100 );
        stats.setPourcentage20( ( nombrePourcentage20 * 1.0 / nombreParticipants ) * 100 );

        // Affectations des attributs de la requete
        request.setAttribute( ATT_COURS, cours );

        request.setAttribute( ATT_STATS, stats );

        request.setAttribute( ATT_LISTE_REPONSE, listeReponses );
        request.setAttribute( ATT_LISTE_QUESTION, listeQuestions );

        request.setAttribute( ATT_REPONSE_UTILISATEUR, reponsesUtilisateur );
        request.setAttribute( ATT_COURS_UTILISATEUR, coursUtilisateur );

        // Affectations des attributs de la session
        session.setAttribute( ATT_SESSION_COURS_UTILISATEUR, mapCoursUtilisateur );

        // Redirection
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
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
