<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Administration</title>
    <c:import url="/inc/header.jsp" />
    <link href="<c:url value="/inc/utilisateur.css"/> " rel="stylesheet" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
    
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/index.jsp"/>"><li class="chemin_li">Get Up English</li></a>
                /
                <a href="<c:url value="/profil"/>"><li class="chemin_li"> ${ sessionScope.sessionUtilisateur.nom } ${ sessionScope.sessionUtilisateur.prenom }</li></a>
                /
                <li class="chemin_li">Historique des notes</li>
            </ul>
        </div>
                
        <div class="contenue">
            <div  class="c_tab">
                <table>
                    <tr class="c_item_1">
                        <td class="c_text">#</td>
                        <td class="c_text_email">Cours</td>
                        <td class="c_text">Note</td>
                    </tr>
                    
                    <c:forEach items="${ requestScope.historique }" var="mapHistorique" varStatus="status">
						<tr class="c_item">
						    <td class="c_text"> ${ status.count } </td>
                            
                            <td class="c_text_email">
                                <a href="
	                            <c:url value="/afficherCours">
	                                <c:param name="id" value="${ mapHistorique.key }" />
	                                <c:param name="source" value="profil" />
	                            </c:url>
	                            ">
                                    <c:out value="${ mapHistorique.value.cours.titre }"/>
                                </a>
                            </td>
                            <td class="c_text">
                                <strong>
                                    <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ mapHistorique.value.note }" />/20
                                </strong>
                            </td>
						</tr>  
                    </c:forEach>
                    <tr class="c_item">
                        <td class="c_text"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></td>
                        <td class="c_text_email">
                            <a href="#">
                                Moyenne
                            </a>
                        </td>
                        <td class="c_text">
                            <strong>
                                <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.moyenne }" />/20
                            </strong>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
    </main>
</body>
</html>
