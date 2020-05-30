package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.Reponse;

public interface ReponseDao {
    void create( Reponse reponse ) throws DAOException;

    List<Reponse> list( CoursDao coursDao ) throws DAOException;

    void delete( Long idCours ) throws DAOException;
}
