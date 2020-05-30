package com.getupenglish.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;

@WebServlet( "/afficherCours" )
public class AfficherCours extends HttpServlet {
    private static final String ATT_SESSION_COURS    = "mapCours";
    private static final String ATT_SESSION_REPONSE  = "reponses";
    private static final String ATT_SESSION_QUESTION = "questions";

    private static final String ATT_COURS            = "cours";
    private static final String ATT_LISTE_REPONSE    = "listeReponses";
    private static final String ATT_LISTE_QUESTION   = "listeQuestions";
    private static final String ATT_SOURCE           = "source";

    private static final String PARAM_ID             = "id";
    private static final String PARAM_SOURCE         = "source";

    private static final String VUE                  = "/afficher_cours.jsp";
    private static final String VUE_ECHEC            = "/cours.jsp";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idValeur = getValeurParam( request, PARAM_ID );
        String source = getValeurParam( request, PARAM_SOURCE );

        if ( idValeur != null ) {
            try {
                Long id = Long.parseLong( idValeur );

                Map<Long, Cours> mapCours = (Map<Long, Cours>) request.getSession().getAttribute( ATT_SESSION_COURS );
                Cours cours = mapCours.get( id );

                if ( mapCours != null && cours != null ) {
                    request.setAttribute( ATT_COURS, cours );
                    Map<Long, Reponse> reponses = (Map<Long, Reponse>) request.getSession()
                            .getAttribute( ATT_SESSION_REPONSE );
                    Map<Long, Question> questions = (Map<Long, Question>) request.getSession()
                            .getAttribute( ATT_SESSION_QUESTION );

                    List<Reponse> listeReponses = new ArrayList<Reponse>();
                    List<Question> listeQuestions = new ArrayList<Question>();
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
                    request.setAttribute( ATT_LISTE_REPONSE, listeReponses );
                    request.setAttribute( ATT_LISTE_QUESTION, listeQuestions );
                } else {
                    this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                    return;
                }
            } catch ( NumberFormatException e ) {
                e.printStackTrace();
                this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
                return;
            }

            request.setAttribute( ATT_SOURCE, source );
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        } else {
            this.getServletContext().getRequestDispatcher( VUE_ECHEC ).forward( request, response );
        }
    }

    @Override
    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
    }

    private static String getValeurParam( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur.trim();
        }
    }
}
