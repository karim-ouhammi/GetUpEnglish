package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.CoursUtilisateur;

public interface CoursUtilisateurDao {
    void create( CoursUtilisateur coursUtilisateur ) throws DAOException;

    CoursUtilisateur read( Long idCours, String email, CoursDao coursDao, UtilisateurDao utilisateurDao )
            throws DAOException;

    List<CoursUtilisateur> list( CoursDao coursDao, UtilisateurDao utilisateurDao ) throws DAOException;

    void delete( String email ) throws DAOException;

    void delete( Long idCours ) throws DAOException;

    void update( CoursUtilisateur coursUtilisateur ) throws DAOException;

}
