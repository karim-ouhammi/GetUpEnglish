package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.Utilisateur;

public interface UtilisateurDao {
    // public abstract 100%
    void create( Utilisateur utilisateur ) throws DAOException;

    Utilisateur read( String email ) throws DAOException;

    void delete( String email ) throws DAOException;

    void update( Utilisateur utilisateur, String email ) throws DAOException;

    List<Utilisateur> list() throws DAOException;
}
