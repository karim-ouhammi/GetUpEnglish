package com.getupenglish.dao;

import java.util.List;

import com.getupenglish.beans.Question;

public interface QuestionDao {
    void create( Question question ) throws DAOException;

    List<Question> list( CoursDao coursDao ) throws DAOException;

    void delete( Long id ) throws DAOException;

    void deleteToutQuestion( Long idCours ) throws DAOException;
}
