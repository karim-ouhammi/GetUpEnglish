package com.getupenglish.dao;

import static com.getupenglish.dao.DAOUtility.close;
import static com.getupenglish.dao.DAOUtility.initPreparedQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.getupenglish.beans.CoursUtilisateur;

public class CoursUtilisateurDaoImp implements CoursUtilisateurDao {
    private static final String SQL_SELECT         = "SELECT idCours, email, note FROM CoursUtilisateur";
    private static final String SQL_SELECT_ID      = "SELECT idCours, email, note FROM CoursUtilisateur WHERE idCours = ? and email = ?";
    private static final String SQL_INSERT         = "INSERT INTO CoursUtilisateur (idCours, email, note) VALUES (?, ?, ?)";
    private static final String SQL_DELETE_EMAIL   = "DELETE FROM CoursUtilisateur WHERE email = ?";
    private static final String SQL_DELETE_IDCOURS = "DELETE FROM CoursUtilisateur WHERE idCours = ?";
    private static final String SQL_UPDATE         = "UPDATE CoursUtilisateur SET note = ? WHERE idCours = ? and email = ?";

    private DAOFactory          daoFactory;

    public CoursUtilisateurDaoImp( DAOFactory daoFactory ) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void create( CoursUtilisateur coursUtilisateur ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();

            preparedStatement = initPreparedQuery( connection, SQL_INSERT, false, coursUtilisateur.getCours().getId(),
                    coursUtilisateur.getUtilisateur().getEmail(), coursUtilisateur.getNote() );
            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la validation des réponses." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } catch ( Exception e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    @Override
    public CoursUtilisateur read( Long idCours, String email, CoursDao coursDao, UtilisateurDao utilisateurDao )
            throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        CoursUtilisateur coursUtilisateur = null;

        try {
            connection = daoFactory.getConnection();

            preparedStatement = initPreparedQuery( connection, SQL_SELECT_ID, false, idCours, email );

            rs = preparedStatement.executeQuery();
            if ( rs.next() ) {
                coursUtilisateur = map( rs, coursDao, utilisateurDao );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( rs, preparedStatement, connection );
        }

        return coursUtilisateur;
    }

    @Override
    public List<CoursUtilisateur> list( CoursDao coursDao, UtilisateurDao utilisateurDao ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<CoursUtilisateur> coursUtilisateurs = new ArrayList<CoursUtilisateur>();

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_SELECT, false );

            rs = preparedStatement.executeQuery();
            while ( rs.next() ) {
                coursUtilisateurs.add( map( rs, coursDao, utilisateurDao ) );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( rs, preparedStatement, connection );
        }

        return coursUtilisateurs;
    }

    @Override
    public void delete( String email ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_DELETE_EMAIL, false, email );

            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la suppression." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    @Override
    public void delete( Long idCours ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();
            preparedStatement = initPreparedQuery( connection, SQL_DELETE_IDCOURS, false, idCours );

            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la suppression." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    @Override
    public void update( CoursUtilisateur coursUtilisateur ) throws DAOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = daoFactory.getConnection();

            preparedStatement = initPreparedQuery( connection, SQL_UPDATE, false, coursUtilisateur.getNote(),
                    coursUtilisateur.getCours().getId(), coursUtilisateur.getUtilisateur().getEmail() );
            int status = preparedStatement.executeUpdate();
            if ( status == 0 ) {
                throw new DAOException( "Échec de la mise a jour de la note, aucune ligne modifier." );
            }
        } catch ( SQLException e ) {
            throw new DAOException( e );
        } catch ( Exception e ) {
            throw new DAOException( e );
        } finally {
            close( preparedStatement, connection );
        }
    }

    private static CoursUtilisateur map( ResultSet rs, CoursDao coursDao, UtilisateurDao utilisateurDao )
            throws SQLException {
        CoursUtilisateur coursUtilisateur = new CoursUtilisateur();

        coursUtilisateur.setNote( rs.getDouble( "note" ) );
        coursUtilisateur.setCours( coursDao.read( rs.getLong( "idCours" ) ) );
        coursUtilisateur.setUtilisateur( utilisateurDao.read( rs.getString( "email" ) ) );

        return coursUtilisateur;
    }
}
