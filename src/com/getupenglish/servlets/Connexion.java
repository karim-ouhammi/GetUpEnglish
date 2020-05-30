package com.getupenglish.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Utilisateur;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.UtilisateurDao;
import com.getupenglish.forms.ConnexionForm;

@WebServlet( "/connexion" )
public class Connexion extends HttpServlet {
    private static final String CONF_DAO_FACTORY = "daoFactory";

    private static final String VUE              = "/WEB-INF/connexion.jsp";
    private static final String VUE_SUCCES       = "/index.jsp";

    private static final String ATT_USER         = "utilisateur";
    private static final String ATT_FORM         = "form";
    private static final String ATT_SESSION_USER = "sessionUtilisateur";

    private UtilisateurDao      utilisateurDao;

    public void init() throws ServletException {
        this.utilisateurDao = ( (DAOFactory) getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getUtilisateurDao();
    }

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute( ATT_SESSION_USER );
        if ( user != null ) {
            this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request, response );
            return;
        }

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }

    protected void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        /* Préparation de l'objet formulaire */
        ConnexionForm form = new ConnexionForm( utilisateurDao );
        Utilisateur utilisateur = form.connecterUtilisateur( request );

        HttpSession session = request.getSession();

        /**
         * Si aucune erreur de validation n'a eu lieu, alors ajout du bean
         * Utilisateur à la session, sinon suppression du bean de la session. ET
         * Stockage du formulaire et du bean dans l'objet request
         */
        request.setAttribute( ATT_USER, utilisateur );
        request.setAttribute( ATT_FORM, form );

        if ( form.getErreurs().isEmpty() ) {
            session.setAttribute( ATT_SESSION_USER, utilisateur );
            this.getServletContext().getRequestDispatcher( VUE_SUCCES ).forward( request, response );
        } else {
            session.setAttribute( ATT_SESSION_USER, null );
            this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
        }
    }
}
