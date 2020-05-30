package com.getupenglish.filters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Cours;
import com.getupenglish.beans.CoursUtilisateur;
import com.getupenglish.beans.Question;
import com.getupenglish.beans.Reponse;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.CoursUtilisateurDao;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.QuestionDao;
import com.getupenglish.dao.ReponseDao;
import com.getupenglish.dao.UtilisateurDao;

@WebFilter( urlPatterns = "/*" )
public class PrechargementFilter implements Filter {
    private static final String CONF_DAO_FACTORY              = "daoFactory";

    private static final String ATT_SESSION_COURS             = "mapCours";
    private static final String ATT_SESSION_QUESTION          = "questions";
    private static final String ATT_SESSION_REPONSE           = "reponses";
    private static final String ATT_SESSION_COURS_UTILISATEUR = "coursUtilisateurs";

    private CoursDao            coursDao;
    private QuestionDao         questionDao;
    private ReponseDao          reponseDao;
    private CoursUtilisateurDao coursUtilisateurDao;
    private UtilisateurDao      utilisateurDao;

    public void init( FilterConfig config ) throws ServletException {
        this.coursDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getCoursDao();
        this.questionDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getQuestionDao();
        this.reponseDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getReponseDao();
        this.coursUtilisateurDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getCoursUtilisateurDao();
        this.utilisateurDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getUtilisateurDao();
    }

    public void doFilter( ServletRequest req, ServletResponse resp, FilterChain chain )
            throws IOException, ServletException {
        /* Cast de l'objet request */
        HttpServletRequest request = (HttpServletRequest) req;

        /* Récupération de la session depuis la requête */
        HttpSession session = request.getSession();

        /*
         * Si la map des cours n'existe pas en session, alors le
         * visiteur/utilisateur visite/se connecte pour la première fois et nous
         * devons précharger en session les infos contenues dans la BDD.
         */
        if ( session.getAttribute( ATT_SESSION_COURS ) == null ) {
            List<Cours> listeCours = coursDao.list();
            Map<Long, Cours> mapCours = new HashMap<Long, Cours>();
            for ( Cours cours : listeCours ) {
                mapCours.put( cours.getId(), cours );
            }

            // Trie par keyValue = idCours dans l'ordre décroissant
            mapCours = mapCours.entrySet().stream().sorted( Collections.reverseOrder( Map.Entry.comparingByKey() ) )
                    .collect( Collectors.toMap( Map.Entry::getKey, Map.Entry::getValue,
                            ( oldValue, newValue ) -> oldValue, LinkedHashMap::new ) );

            session.setAttribute( ATT_SESSION_COURS, mapCours );
        }
        /*
         * De même pour la map des questions
         */
        if ( session.getAttribute( ATT_SESSION_QUESTION ) == null ) {
            List<Question> questions = questionDao.list( coursDao );
            Map<Long, Question> mapQuestions = new HashMap<Long, Question>();
            for ( Question question : questions ) {
                mapQuestions.put( question.getId(), question );
            }
            session.setAttribute( ATT_SESSION_QUESTION, mapQuestions );
        }
        /*
         * De même pour la map des reponses
         */
        if ( session.getAttribute( ATT_SESSION_REPONSE ) == null ) {
            List<Reponse> reponses = reponseDao.list( coursDao );
            Map<Long, Reponse> mapReponses = new HashMap<Long, Reponse>();
            for ( Reponse reponse : reponses ) {
                mapReponses.put( reponse.getId(), reponse );
            }
            session.setAttribute( ATT_SESSION_REPONSE, mapReponses );
        }
        /*
         * De même pour la map des coursUtilisateurs
         */
        if ( session.getAttribute( ATT_SESSION_COURS_UTILISATEUR ) == null ) {
            List<CoursUtilisateur> coursUtilisateurs = coursUtilisateurDao.list( coursDao, utilisateurDao );

            Map<Long, List<CoursUtilisateur>> mapCoursUtilisateur = new HashMap<Long, List<CoursUtilisateur>>();

            Map<Long, Cours> mapCours = (Map<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );

            for ( Map.Entry<Long, Cours> entry : mapCours.entrySet() ) {
                List<CoursUtilisateur> listeCoursUtlisateur = new ArrayList<CoursUtilisateur>();
                for ( CoursUtilisateur coursUtilisateur : coursUtilisateurs ) {
                    if ( coursUtilisateur.getCours().getId() == entry.getValue().getId() ) {
                        listeCoursUtlisateur.add( coursUtilisateur );
                    }
                }
                mapCoursUtilisateur.put( entry.getValue().getId(), listeCoursUtlisateur );
            }

            session.setAttribute( ATT_SESSION_COURS_UTILISATEUR, mapCoursUtilisateur );
        }

        /* Pour terminer, poursuite de la requête en cours */
        chain.doFilter( request, resp );
    }

    public void destroy() {
    }
}
