package com.getupenglish.servlets.administration;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Cours;
import com.getupenglish.dao.CoursDao;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.ReponseDao;
import com.getupenglish.forms.AjouterCoursForm;

@WebServlet( "/adminAjouterCours" )
public class AdminAjouterCours extends HttpServlet {
    private static final String CONF_DAO_FACTORY    = "daoFactory";

    private static final String ATT_COURS           = "cours";
    private static final String ATT_FORM            = "form";

    private static final String ATT_SESSION_COURS   = "mapCours";
    private static final String ATT_SESSION_REPONSE = "reponses";

    private static final String VUE                 = "/WEB-INF/administration/ajouter_cours.jsp";
    private static final String VUE_SUCCES          = "/WEB-INF/administration/cours.jsp";

    private CoursDao            coursDao;
    private ReponseDao          reponseDao;

    public void init() throws ServletException {
        this.coursDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getCoursDao();
        this.reponseDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getReponseDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Affichage de la page des cours pour admin */
        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        AjouterCoursForm form = new AjouterCoursForm( coursDao, reponseDao );
        Cours cours = form.ajouterCours( request );

        request.setAttribute( ATT_COURS, cours );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            HttpSession session = request.getSession();
            Map<Long, Cours> mapCours = (HashMap<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );

            if ( mapCours == null ) {
                mapCours = new HashMap<Long, Cours>();
            }
            mapCours.put( cours.getId(), cours );

            // Trie par keyValue = idCours dans l'ordre décroissant
            mapCours = mapCours.entrySet().stream().sorted( Collections.reverseOrder( Map.Entry.comparingByKey() ) )
                    .collect( Collectors.toMap( Map.Entry::getKey, Map.Entry::getValue,
                            ( oldValue, newValue ) -> oldValue, LinkedHashMap::new ) );

            session.setAttribute( ATT_SESSION_COURS, mapCours );
            request.removeAttribute( ATT_COURS );

            this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request, response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}
