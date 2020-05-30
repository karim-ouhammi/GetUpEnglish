<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Erreur 404</title>
    <c:import url="/inc/header.jsp" />
    <link href="<c:url value="/inc/profile.css"/> " rel="stylesheet" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
        
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/index.jsp"/>"><li class="chemin_li">Get Up English</li></a>
                /
                <li class="chemin_li"> Erreur 404 - Page non trouvée</li>
            </ul>
        </div>
    
        <p>
            La page que vous recherchez est introuvable. Voici quelques liens utiles pour vous remettre sur la bonne voie:
        </p>
        
        <div class="info">
        
            <div class="info_line">
                <div class="info_content">
                    <a href="<c:url value="/index.jsp"/>">
	                    <i class="fa fa-home"></i>
	                    <span class="info_text">Accueil</span>
                    </a>
                </div>
            </div>
            
            <div class="info_line">
                <div class="info_content">
                    <a href="<c:url value="/cours.jsp"/>">
                        <i class="fa fa-book" ></i>
                        <span class="info_text">Cours</span>
                    </a>
                </div>
            </div>
            
            <div class="info_line">
                <div class="info_content">
                    <a href="<c:url value="/contact.jsp"/>">
                        <i class="fa fa-envelope" aria-hidden="true"></i>
                        <span class="info_text">Contact</span>
                    </a>
                </div>
            </div>
            
            <c:choose>
                 <c:when test="${ empty sessionScope.sessionUtilisateur }">
			<div class="info_line">
				<div class="info_content">
					<a href="<c:url value="/connexion"/>">
						<i class="fa fa-sign-in"></i>
						<span class="info_text">Connexion</span>
					</a>
				</div>
			</div>
		            
		        <div class="info_line">
                        	<div class="info_content">
				    <a href="<c:url value="/inscription"/>">
					<i class="fa fa-user-plus"></i>
					<span class="info_text">Inscription</span>
				    </a>
                        	</div>
                    	</div>
                 </c:when>
                 <c:otherwise>
                    <div class="info_line">
                        <div class="info_content">
                            <a href="<c:url value="/profil"/>">
                                <i class="fa fa-user" aria-hidden="true"></i>
                                <span class="info_text">${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }</span>
                            </a>
                        </div>
                    </div>
                    
                    <c:if test="${ sessionUtilisateur.isAdmin() }">
                        <div class="info_line">
	                        <div class="info_content">
	                           <a href="<c:url value="/administration"/>">
                                    <i class="fa fa-cog" aria-hidden="true"></i>
                                    <span class="info_text">Administration</span>
                                </a>
	                            <a href="<c:url value="/adminCours"/>">
	                                <i class="fa fa-book" ></i>
	                                <span class="info_text">Cours</span>
	                            </a>
	                            <a href="<c:url value="/adminUtilisateurs"/>">
                                    <i class="fa fa-users" aria-hidden="true"></i>
                                    <span class="info_text">Utilisateurs</span>
                                </a>
                                <a href="<c:url value="/adminMessages"/>">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                    <span class="info_text">Messages (${ sessionScope.notification })</span>
                                </a>
	                        </div>
	                    </div>
                    </c:if>
                    
                 </c:otherwise>
            
            </c:choose>
        
        </div>

    </main>
    
    <c:import url="/inc/footer.jsp" />
    
</body>
</html>
