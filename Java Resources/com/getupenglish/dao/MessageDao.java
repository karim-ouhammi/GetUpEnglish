package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.Message;

public interface MessageDao {
    void create( Message message ) throws DAOException;

    List<Message> list( UtilisateurDao utilisateurDao ) throws DAOException;

    void delete( Long id ) throws DAOException;

    void update( Message message, boolean vu ) throws DAOException;
}
