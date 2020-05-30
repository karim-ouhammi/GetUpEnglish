package com.getupenglish.servlets;

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

import com.getupenglish.beans.CoursUtilisateur;
import com.getupenglish.beans.Utilisateur;

@WebServlet( "/historique" )
public class Historique extends HttpServlet {
    private static final String VUE                           = "/WEB-INF/historique_notes.jsp";

    private static final String ATT_SESSION_USER              = "sessionUtilisateur";
    private static final String ATT_SESSION_COURS_UTILISATEUR = "coursUtilisateurs";

    private static final String ATT_HISTORIQUE                = "historique";
    private static final String ATT_MOYENNE                   = "moyenne";

    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // CoursUtilisateur
        Map<Long, List<CoursUtilisateur>> mapCoursUtilisateur = (HashMap<Long, List<CoursUtilisateur>>) session
                .getAttribute( ATT_SESSION_COURS_UTILISATEUR );
        // User
        Utilisateur utilisateur = (Utilisateur) session.getAttribute( ATT_SESSION_USER );

        // Pour le calcul du moyenne
        Double moyenne = 0.0;
        int nombreDesExercices = 0;

        Map<Long, CoursUtilisateur> map = new HashMap<Long, CoursUtilisateur>();

        for ( Map.Entry<Long, List<CoursUtilisateur>> entry : mapCoursUtilisateur.entrySet() ) {
            List<CoursUtilisateur> listeCoursUtlisateur = entry.getValue();
            for ( CoursUtilisateur coursUtilisateur : listeCoursUtlisateur ) {
                if ( coursUtilisateur.getUtilisateur().getEmail().equals( utilisateur.getEmail() ) ) {
                    map.put( coursUtilisateur.getCours().getId(), coursUtilisateur );
                    nombreDesExercices++;
                    moyenne += coursUtilisateur.getNote();
                }
            }
        }
        if ( nombreDesExercices == 0 ) {
            moyenne = 0.0;
        } else {
            // Calcul de la moyenne
            moyenne = moyenne / nombreDesExercices;
        }

        request.setAttribute( ATT_HISTORIQUE, map );
        request.setAttribute( ATT_MOYENNE, moyenne );

        this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
    }
}