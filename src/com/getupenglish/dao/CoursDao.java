package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.Cours;

public interface CoursDao {
    void create( Cours cours ) throws DAOException;

    void delete( Long id ) throws DAOException;

    Cours read( Long id ) throws DAOException;

    void update( Cours cours ) throws DAOException;

    List<Cours> list() throws DAOException;
}
