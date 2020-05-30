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
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.forms.ModifierCoursForm;

@WebServlet( "/adminModificationCours" )
public class AdminModificationCours extends HttpServlet {
    private static final String CONF_DAO_FACTORY  = "daoFactory";

    private static final String ATT_COURS         = "cours";
    private static final String ATT_FORM          = "form";

    private static final String ATT_SESSION_COURS = "mapCours";

    private static final String PARAM_ID          = "id";

    private static final String VUE               = "/WEB-INF/administration/modifier_cours.jsp";
    private static final String VUE_COURS         = "/WEB-INF/administration/cours.jsp";

    private CoursDao            coursDao;

    public void init() throws ServletException {
        this.coursDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getCoursDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idCours = getValeurParam( request, PARAM_ID );

        Long id = null;
        try {
            id = Long.parseLong( idCours );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
            return;
        }

        HttpSession session = request.getSession();

        Map<Long, Cours> mapCours = (HashMap<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );

        Cours cours = mapCours.get( id );

        if ( cours != null ) {
            request.setAttribute( ATT_COURS, cours );
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        } else {
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
        }
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String idCours = getValeurParam( request, PARAM_ID );

        Long id = null;
        try {
            id = Long.parseLong( idCours );
        } catch ( NumberFormatException e ) {
            e.printStackTrace();
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
            return;
        }

        HttpSession session = request.getSession();

        Map<Long, Cours> mapCours = (HashMap<Long, Cours>) session.getAttribute( ATT_SESSION_COURS );

        Cours cours = mapCours.get( id );

        /* Mise a jour du cours */
        if ( cours != null ) {
            ModifierCoursForm form = new ModifierCoursForm( coursDao );
            cours = form.modifierCours( request, cours );

            request.setAttribute( ATT_COURS, cours );
            request.setAttribute( ATT_FORM, form );

            if ( form.getErreurs().isEmpty() ) {
                mapCours.replace( cours.getId(), cours );

                session.setAttribute( ATT_SESSION_COURS, mapCours );
                request.removeAttribute( ATT_COURS );

                this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
                return;
            }
        } else {
            this.getServletContext().getRequestDispatcher( VUE_COURS ).forward( request, response );
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
