package com.getupenglish.servlets.administration;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Cours;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.CoursUtilisateurDao;
import com.getupenglish.dao.DAOException;
import com.getupenglish.dao.DAOFactory;

@WebServlet( "/adminSuppressionCours" )
public class AdminSuppressionCours extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";
    private static final String PARAM_EMAIL       = "id";

    private static final String ATT_SESSION_COURS = "mapCours";

    private static final String VUE               = "/WEB-INF/administration/cours.jsp";

    private static final String ATT_FORM          = "form";

    private String              resultat;

    private CoursDao            coursDao;
    private CoursUtilisateurDao coursUtilisateurDao;

    public String getResultat() {
        return resultat;
    }

    public void init() throws ServletException {
        this.coursDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getCoursDao();
        this.coursUtilisateurDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getCoursUtilisateurDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        resultat = null;
        String idString = getValeurParametre( request, PARAM_EMAIL );

        HttpSession session = request.getSession();
        Map<Long, Cours> mapCours = (HashMap<Long, Cours>) session
                .getAttribute( ATT_SESSION_COURS );

        /* Si l'id du cours et la Map des cours ne sont pas vides */
        if ( mapCours != null && idString != null ) {
            try {
                Long id = Long.parseLong( idString );

                /* Alors suppression de la base */
                try {
                    coursUtilisateurDao.delete( id );
                } catch ( Exception ignore ) {
                }
                coursDao.delete( id );
                /* Puis suppression du thème de la Map */
                mapCours.remove( id );

                /*
                 * Et remplacement de l'ancienne Map en session par la nouvelle
                 */
                session.setAttribute( ATT_SESSION_COURS, mapCours );
            } catch ( DAOException ignore ) {
                this.resultat = "Échec de la suppression du cours n° : " + idString
                        + ".<br> Vérifiez s'il ne posséde pas des réponses et/ou des questions.";
                request.setAttribute( ATT_FORM, this );
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
