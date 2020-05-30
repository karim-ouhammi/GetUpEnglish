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

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.QuestionDao;
import com.getupenglish.forms.AjouterQuestionForm;

@WebServlet( "/adminAjouterQuestion" )
public class AdminAjouterQuestion extends HttpServlet {
    private static final String CONF_DAO_FACTORY     = "daoFactory";

    private static final String ATT_SESSION_COURS    = "mapCours";
    private static final String ATT_SESSION_REPONSE  = "reponses";
    private static final String ATT_SESSION_QUESTION = "questions";

    private static final String ATT_QUESTION         = "question";
    private static final String ATT_COURS            = "cours";
    private static final String ATT_LISTE_REPONSE    = "listeReponses";
    private static final String ATT_LISTE_QUESTION   = "listeQuestions";

    private static final String ATT_FORM             = "form";

    private static final String PARAM_ID_COURS       = "idCours";

    private static final String VUE                  = "/WEB-INF/administration/ajouter_question.jsp";
    private static final String VUE_COURS            = "/WEB-INF/administration/cours.jsp";
    private static final String VUE_SUCCES           = "/afficher_cours.jsp";

    private QuestionDao         questionDao;

    public void init() throws ServletException {
        this.questionDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getQuestionDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idValeur = getValeurParam( request, PARAM_ID_COURS );

        HttpSession session = request.getSession();
        Map<Long, Cours> mapCours = (Map<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );

        try {
            Question question = new Question();

            Cours cours = mapCours.get( Long.parseLong( idValeur ) );
            if ( cours == null ) {
                this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
                return;
            }
            question.setCours( cours );
            request.setAttribute( ATT_QUESTION, question );

            Map<Long, Reponse> reponses = (Map<Long, Reponse>) request.getSession()
                    .getAttribute( ATT_SESSION_REPONSE );
            Map<Long, Question> questions = (Map<Long, Question>) request.getSession()
                    .getAttribute( ATT_SESSION_QUESTION );

            List<Reponse> listeReponses = new ArrayList<Reponse>();
            List<Question> listeQuestions = new ArrayList<Question>();
            for ( Map.Entry<Long, Reponse> entry : reponses.entrySet() ) {
                if ( entry.getValue().getCours().getId() == cours.getId() ) {
                    listeReponses.add( entry.getValue() );
                }
            }
            for ( Map.Entry<Long, Question> entry : questions.entrySet() ) {
                if ( entry.getValue().getCours().getId() == cours.getId() ) {
                    listeQuestions.add( entry.getValue() );
                }
            }
            request.setAttribute( ATT_LISTE_REPONSE, listeReponses );
            request.setAttribute( ATT_LISTE_QUESTION, listeQuestions );

        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
            return;
        } catch ( NullPointerException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        AjouterQuestionForm form = new AjouterQuestionForm( questionDao );
        Question question = form.ajouterQuestion( request );

        request.setAttribute( ATT_QUESTION, question );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Question> questions = (HashMap<Long, Question>) session.getAttribute( ATT_SESSION_QUESTION );

            if ( questions == null ) {
                questions = new HashMap<Long, Question>();
            }
            questions.put( question.getId(), question );

            Map<Long, Reponse> reponses = (Map<Long, Reponse>) request.getSession()
                    .getAttribute( ATT_SESSION_REPONSE );
            Map<Long, Question> mapQuestions = (Map<Long, Question>) request.getSession()
                    .getAttribute( ATT_SESSION_QUESTION );

            List<Reponse> listeReponses = new ArrayList<Reponse>();
            List<Question> listeQuestions = new ArrayList<Question>();
            for ( Map.Entry<Long, Reponse> entry : reponses.entrySet() ) {
                if ( entry.getValue().getCours().getId() == question.getCours().getId() ) {
                    listeReponses.add( entry.getValue() );
                }
            }
            for ( Map.Entry<Long, Question> entry : mapQuestions.entrySet() ) {
                if ( entry.getValue().getCours().getId() == question.getCours().getId() ) {
                    listeQuestions.add( entry.getValue() );
                }
            }
            request.setAttribute( ATT_LISTE_REPONSE, listeReponses );
            request.setAttribute( ATT_LISTE_QUESTION, listeQuestions );

            session.setAttribute( ATT_SESSION_QUESTION, questions );
            request.setAttribute( ATT_COURS, question.getCours() );
            request.removeAttribute( ATT_QUESTION );

            this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request,
                    response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
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
