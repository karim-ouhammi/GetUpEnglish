<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - ${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }</title>
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
                <li class="chemin_li"> ${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }</li>
            </ul>
        </div>
    
        <div class="info">
            <div class="info_line">
                <div class="info_content">
                    <a href="<c:url value="/historique"/>">
                        <i class="fa fa-history" aria-hidden="true"></i>
                        <span class="info_text">Historique des notes</span>
                    </a>
                </div>
                <div class="info_content">
                    <a href="#">
                        <i class="fa fa-address-card-o"></i>
                        <span class="info_text">${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }</span>
                    </a>
                </div>
            </div>
    
            <div class="info_line">
                <div class="info_content">
                    <a href="#">
                        <i class="fa fa-envelope"></i>
                        <span class="info_text">${ sessionScope.sessionUtilisateur.email }</span>
                    </a>
                </div>
                <div class="info_content">
                    <a href="#">
                        <i class="fa fa-phone"></i>
                        <span class="info_text">${ sessionScope.sessionUtilisateur.telephone }</span>
                    </a>
                </div>
            </div>
            <div class="info_line">
                <div class="info_content">
                    <a href="#">
                        <i class="fa fa-calendar-check-o"></i>
                        <span class="info_text">Age : ${ sessionScope.sessionUtilisateur.age }</span>
                    </a>
                </div>
                <div class="info_content">
                    <a href="#">
                        <i class="fa fa-clock-o" aria-hidden="true"></i>
                        <span class="info_text">Membre depuis : <joda:format value="${ sessionUtilisateur.dateInscription }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></span>
                    </a>
                </div>
            </div>
        </div>
        <div class="btn_fix_div">
            <a href="
            <c:url value="/modificationProfil">
                <c:param name="email" value="${ sessionUtilisateur.email }" />
            </c:url>">
                <font color="#FFFFFF"><i class="fa fa-pencil-square-o"></i></font> <span class="btn_fix_text">Modifier</span>
            </a>
        </div>
    
    </main>
        
</body>
</html>