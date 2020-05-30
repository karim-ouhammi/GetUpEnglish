package com.getupenglish.filters;

import java.io.IOException;
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

import com.getupenglish.beans.Message;
import com.getupenglish.beans.Utilisateur;
import com.getupenglish.dao.DAOFactory;
import com.getupenglish.dao.MessageDao;
import com.getupenglish.dao.UtilisateurDao;

@WebFilter( urlPatterns = "/*" )
public class PrechargementFilterAdmin implements Filter {
    private static final String CONF_DAO_FACTORY         = "daoFactory";

    private static final String ATT_SESSION_ADMIN        = "sessionUtilisateur";

    private static final String ATT_SESSION_UTILISATEUR  = "utilisateurs";
    private static final String ATT_SESSION_MESSAGE      = "messages";
    private static final String ATT_SESSION_NOTIFICATION = "notification";

    private UtilisateurDao      utilisateurDao;
    private MessageDao          messageDao;

    public void init( FilterConfig config ) throws ServletException {
        /* Récupération d'une instance de nos DAO Client et Commande */
        this.utilisateurDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getUtilisateurDao();
        this.messageDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) ).getMessageDao();
        this.utilisateurDao = ( (DAOFactory) config.getServletContext().getAttribute( CONF_DAO_FACTORY ) )
                .getUtilisateurDao();
    }

    public void doFilter( ServletRequest req, ServletResponse resp, FilterChain chain )
            throws IOException, ServletException {
        /* Cast de l'objet request */
        HttpServletRequest request = (HttpServletRequest) req;

        /* Récupération de la session depuis la requête */
        HttpSession session = request.getSession();

        Utilisateur admin = (Utilisateur) session.getAttribute( ATT_SESSION_ADMIN );

        /*
         * Vérification si l'utilisateur se connecte pour la premiere fois, et
         * vérifictation si il s'agit bien d'un compte ADMIN
         */
        if ( admin != null && admin.isAdmin() ) {
            /*
             * Si oui, et si la map des utilisateurs n'existe pas en session,
             * alors l'admin se connecte pour la première fois et nous devons
             * précharger en session les infos contenues dans la BDD (en plus de
             * leurs paniers).
             */
            if ( session.getAttribute( ATT_SESSION_UTILISATEUR ) == null ) {
                List<Utilisateur> utilisateurs = utilisateurDao.list();
                Map<String, Utilisateur> mapUsers = new HashMap<String, Utilisateur>();
                for ( Utilisateur user : utilisateurs ) {
                    mapUsers.put( user.getEmail(), user );
                }
                // Trie par keyValue = email
                mapUsers = mapUsers.entrySet().stream().sorted( Map.Entry.comparingByKey() )
                        .collect( Collectors.toMap( Map.Entry::getKey, Map.Entry::getValue,
                                ( oldValue, newValue ) -> oldValue, LinkedHashMap::new ) );
                session.setAttribute( ATT_SESSION_UTILISATEUR, mapUsers );
            }
            /*
             * De même pour la map des messages
             */
            if ( session.getAttribute( ATT_SESSION_MESSAGE ) == null ) {
                int notification = 0;
                List<Message> messages = messageDao.list( utilisateurDao );
                Map<Long, Message> mapMessages = new HashMap<Long, Message>();
                for ( Message message : messages ) {
                    if ( !message.isVu() ) {
                        notification++;
                    }
                    mapMessages.put( message.getId(), message );
                }
                session.setAttribute( ATT_SESSION_NOTIFICATION, notification );
                session.setAttribute( ATT_SESSION_MESSAGE, mapMessages );
            }
        }
        /* Pour terminer, poursuite de la requête en cours */
        chain.doFilter( request, resp );
    }

    public void destroy() {
    }
}
