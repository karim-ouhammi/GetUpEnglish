package com.getupenglish.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.getupenglish.beans.Utilisateur;

@WebFilter( urlPatterns = "/*" )
public class RestrictionFilter implements Filter {
    private static final String VISITEUR_CONNEXION              = "/connexion";
    private static final String VISITEUR_INSCRIPTION            = "/inscription";
    private static final String VISITEUR_COURS                  = "/cours";
    private static final String VISITEUR_AFFICHER               = "/afficher";
    private static final String VISITEUR_INDEX                  = "/index";
    private static final String VISITEUR_CONTACT                = "/contact";
    private static final String VISITEUR_INC                    = "/inc";
    private static final String VISITEUR_CORRECTION             = "/correction";

    private static final String UTILISATEUR_PROFIL              = "/profil";
    private static final String UTILISATEUR_DECCONNEXION        = "/deconnexion";
    private static final String UTILISATEUR_MODIFICATION_PROFIL = "/modificationProfil";
    private static final String UTILISATEUR_HISTORIQUE          = "/historique";

    private static final String ADMIN_ADMINISTRATION            = "/admin";

    private static final String ACCES_404                       = "/404.jsp";

    private static final String ATT_SESSION_USER                = "sessionUtilisateur";

    public void init( FilterConfig config ) throws ServletException {
    }

    public void doFilter( ServletRequest req, ServletResponse resp, FilterChain chain )
            throws IOException, ServletException {
        /* Cast des objets request et response */
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        /* Non-filtrage des ressources statiques */
        String chemin = request.getRequestURI().substring( request.getContextPath().length() );
        if ( chemin.startsWith( VISITEUR_INC )
                || chemin.startsWith( VISITEUR_INDEX )
                || chemin.startsWith( VISITEUR_CONNEXION )
                || chemin.startsWith( VISITEUR_INSCRIPTION )
                || chemin.startsWith( VISITEUR_COURS )
                || chemin.startsWith( VISITEUR_AFFICHER )
                || chemin.startsWith( VISITEUR_CONTACT )
                || chemin.startsWith( VISITEUR_CORRECTION )
                || chemin.startsWith( ACCES_404 )
                || chemin.length() <= 1 ) {
            chain.doFilter( request, response );
            return;
        }

        /* Récupération de la session depuis la requête */
        HttpSession session = request.getSession();

        /**
         * Si l'objet utilisateur n'existe pas dans la session en cours, alors
         * l'utilisateur n'est pas connecté.
         */
        Utilisateur user = (Utilisateur) session.getAttribute( ATT_SESSION_USER );
        if ( user == null ) {
            // response.sendRedirect(request.getContextPath() + ACCES_404);
            request.getRequestDispatcher( ACCES_404 ).forward( request, response );
        } else {
            if ( chemin.startsWith( UTILISATEUR_PROFIL )
                    || chemin.startsWith( UTILISATEUR_MODIFICATION_PROFIL )
                    || chemin.startsWith( UTILISATEUR_HISTORIQUE )
                    || chemin.startsWith( UTILISATEUR_DECCONNEXION ) ) {
                chain.doFilter( request, response );
                return;
            } else {
                if ( user.isAdmin() ) {
                    if ( chemin.startsWith( ADMIN_ADMINISTRATION ) ) {
                        chain.doFilter( request, response );
                        return;
                    } else {
                        request.getRequestDispatcher( ACCES_404 ).forward( request, response );
                    }
                } else {
                    request.getRequestDispatcher( ACCES_404 ).forward( request, response );
                }
            }
        }
    }

    public void destroy() {
    }
}
