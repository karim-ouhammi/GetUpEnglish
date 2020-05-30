package com.getupenglish.servlets.administration;

import java.io.IOException;
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
import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.DAOException;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.QuestionDao;
import com.getupenglish.dao.ReponseDao;

@WebServlet( "/adminSuppressionExercice" )
public class AdminSuppressionExercice extends HttpServlet {
    private static final String CONF_DAO_FACTORY     = "daoFactory";
    private static final String PARAM_ID             = "id";

    private static final String ATT_SESSION_COURS    = "mapCours";
    private static final String ATT_SESSION_QUESTION = "questions";
    private static final String ATT_SESSION_REPONSE  = "reponses";

    private static final String ATT_COURS            = "cours";

    private static final String VUE                  = "/afficher_cours.jsp";

    private CoursDao            coursDao;
    private QuestionDao         questionDao;
    private ReponseDao          reponseDao;

    public void init() throws ServletException {
        this.coursDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getCoursDao();
        this.questionDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getQuestionDao();
        this.reponseDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getReponseDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idString = getValeurParametre( request, PARAM_ID );

        HttpSession session = request.getSession();
        Map<Long, Cours> mapCours = (HashMap<Long, Cours>) session
                .getAttribute( ATT_SESSION_COURS );
        Map<Long, Reponse> reponses = (Map<Long, Reponse>) request.getSession()
                .getAttribute( ATT_SESSION_REPONSE );

        if ( reponses != null && idString != null ) {
            try {
                Long idCours = Long.parseLong( idString );

                request.setAttribute( ATT_COURS, mapCours.get( idCours ) );

                /* Alors suppression de la base */
                try {
                    questionDao.deleteToutQuestion( idCours );
                } catch ( DAOException ignore ) {
                    ignore.getStackTrace();
                }
                reponseDao.delete( idCours );
                /* Puis suppression de la Map */
                List<Question> listeQuestions = questionDao.list( coursDao );
                Map<Long, Question> mapQuestions = new HashMap<Long, Question>();
                for ( Question question : listeQuestions ) {
                    mapQuestions.put( question.getId(), question );
                }

                List<Reponse> listeReponses = reponseDao.list( coursDao );
                Map<Long, Reponse> mapReponses = new HashMap<Long, Reponse>();
                for ( Reponse reponse : listeReponses ) {
                    mapReponses.put( reponse.getId(), reponse );
                }
                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_QUESTION, mapQuestions );
                session.setAttribute( ATT_SESSION_REPONSE, mapReponses );

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
