package com.getupenglish.servlets.administration;

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

import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;
import com.getupenglish.dao.DAOException;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.QuestionDao;

@WebServlet( "/adminSuppressionQuestion" )
public class AdminSuppressionQuestion extends HttpServlet {
    private static final String CONF_DAO_FACTORY     = "daoFactory";
    private static final String PARAM_ID             = "id";

    private static final String ATT_SESSION_QUESTION = "questions";
    private static final String ATT_SESSION_REPONSE  = "reponses";

    private static final String ATT_COURS            = "cours";

    private static final String ATT_LISTE_REPONSE    = "listeReponses";
    private static final String ATT_LISTE_QUESTION   = "listeQuestions";

    private static final String VUE                  = "/afficher_cours.jsp";

    private QuestionDao         questionDao;

    public void init() throws ServletException {
        this.questionDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getQuestionDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idString = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Question> questions = (HashMap<Long, Question>) session
                .getAttribute( ATT_SESSION_QUESTION );

        if ( questions != null && idString != null ) {
            try {
                Long id = Long.parseLong( idString );
                Question question = questions.get( id );

                request.setAttribute( ATT_COURS, question.getCours() );

                /* Alors suppression de la base */
                questionDao.delete( id );
                /* Puis suppression du thème de la Map */
                questions.remove( id );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_QUESTION, questions );

                Map<Long, Reponse> reponses = (Map<Long, Reponse>) request.getSession()
                        .getAttribute( ATT_SESSION_REPONSE );

                List<Reponse> listeReponses = new ArrayList<Reponse>();
                List<Question> listeQuestions = new ArrayList<Question>();
                for ( Map.Entry<Long, Reponse> entry : reponses.entrySet() ) {
                    if ( entry.getValue().getCours().getId() == question.getCours().getId() ) {
                        listeReponses.add( entry.getValue() );
                    }
                }
                for ( Map.Entry<Long, Question> entry : questions.entrySet() ) {
                    if ( entry.getValue().getCours().getId() == question.getCours().getId() ) {
                        listeQuestions.add( entry.getValue() );
                    }
                }
                request.setAttribute( ATT_LISTE_REPONSE, listeReponses );
                request.setAttribute( ATT_LISTE_QUESTION, listeQuestions );

            } catch ( DAOException ignore ) {
                ignore.printStackTrace();
            } catch ( NumberFormatException ignore ) {
                ignore.printStackTrace();
            } catch ( Exception e ) {
                e.printStackTrace();
            }
        }
        /* Redirection vers la fiche récapitulative */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    private static String getValeurParametre( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur;
        }
    }
}
