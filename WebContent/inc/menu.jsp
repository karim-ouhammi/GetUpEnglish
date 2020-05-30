<%@ page pageEncoding="UTF-8" %>
<nav class="navbar">
        <ul class="navbar-nav">
            <li class="logo">
                <a href="<c:url value="/index.jsp"/>"class="nav-link">
                    <span class="link-text">GUEnglish</span>
                    <i class="fa fa-arrow-right"></i>
                </a>
            </li>
            <li class="nav-item">
                <a href="<c:url value="/index.jsp"/>" class="nav-link">
                    <i class="fa fa-home"></i>
                    <span class="link-text">Accueil</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<c:url value="/cours.jsp"/>" class="nav-link">
                    <i class="fa fa-book" ></i>
                    <span class="link-text">Cours</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<c:url value="/contact"/>"class="nav-link">
                    <i class="fa fa-envelope" aria-hidden="true"></i>
                    <span class="link-text">Contact</span>
                </a>
            </li>
            <c:choose>
                <c:when test="${ empty sessionScope.sessionUtilisateur }">
                    <li class="nav-item">
                        <a href="<c:url value="/connexion"/>"class="nav-link">
                            <i class="fa fa-sign-in"></i>
                            <span class="link-text">Connexion</span>
                        </a>
                    </li>
                    <li class="nav-item">
		                <a href="<c:url value="/inscription"/>" class="nav-link">
		                    <i class="fa fa-user-plus"></i>
		                    <span class="link-text">Inscription</span>
		                </a>
		            </li>
                </c:when>
                <c:otherwise>
                
                    <li class="nav-item">
                        <a href="<c:url value="/profil"/>" class="nav-link">
                            <i class="fa fa-user" aria-hidden="true"></i>
                            <span class="link-text">${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom } </span>
                        </a>
                    </li>
                    
                    <c:if test="${ sessionUtilisateur.isAdmin() }">
                        <li class="nav-item">
	                        <a href="<c:url value="/administration"/>" class="nav-link">
	                            <i class="fa fa-cog" aria-hidden="true"></i>
	                            <span class="link-text">Administration</span>
	                        </a>
	                        <div class="EAL_div">
				    <ul>
					<li class="EAL_item"><a href="<c:url value="/adminCours" />" class="EAL_link"><span class="EAL_link_text"><i class="fa fa-book" ></i> Cours</span></a></li>
					<li class="EAL_item"><a href="<c:url value="/adminUtilisateurs" />" class="EAL_link"><span class="EAL_link_text"><i class="fa fa-users" aria-hidden="true"></i> Utilisateurs</span></a></li>
					<li class="EAL_item"><a href="<c:url value="/adminMessages" />" class="EAL_link"><span class="EAL_link_text"><i class="fa fa-envelope" aria-hidden="true"></i> Messages (${ sessionScope.notification })</span></a></li>
				    </ul>
				</div>
                        </li>
                    </c:if>
                    
                    <li class="nav-item">
                        <a href="<c:url value="/deconnexion"/>" class="nav-link">
                            <i class="fa fa-sign-out"></i>
                            <span class="link-text">Déconnexion </span>
                        </a>
                    </li>
                    
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
