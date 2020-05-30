<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

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
                <a href="<c:url value="/administration" />"><li class="chemin_li">Espace Administrateur</li></a>
                /
                <li class="chemin_li">Utilisateurs</li>
            </ul>
        </div>
                
        <div class="contenue">
            <div  class="c_tab">
                <table>
	                <tr class="c_item_1">
	                    <td class="c_text">#</td>
	                    <td class="c_text_email">Email</td>
	                    <td class="c_text">Nom</td>
	                    <td class="c_text">Prenom</td>
	                    <td class="c_text">Age</td>
	                    <td class="c_text">Telephone</td>
	                    <td class="c_text">Date d'nscription</td>
	                    <td class="c_text">Action</td>
	                </tr>
	                
	                <c:forEach items="${ sessionScope.utilisateurs }" var="mapUsers" varStatus="status">
		                <tr class="c_item">
		                    <td class="c_text"> ${ status.count } </td>
		                    <td class="c_text_email"> <c:out value="${ mapUsers.value.email }"/> </td>
		                    <td class="c_text"> <c:out value="${ mapUsers.value.nom }"/> </td>
		                    <td class="c_text"> <c:out value="${ mapUsers.value.prenom }"/> </td>
		                    <td class="c_text"> <c:out value="${ mapUsers.value.age }"/> </td>
		                    <td class="c_text"> <c:out value="${ mapUsers.value.telephone }"/> </td>
		                    <td class="c_text"> <joda:format value="${  mapUsers.value.dateInscription }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format> </td>
		                    <td class="c_text">
			                     <c:if test="${ !mapUsers.value.isAdmin() }">
								    <a href="
								        <c:url value="/adminSuppressionUtilisateur">
								            <c:param name="email" value="${ mapUsers.key }" />
								        </c:url>">
								        <i class="fa fa-trash-o" aria-hidden="true"></i>
								    </a>
								</c:if>
		                    </td>
		                </tr>
	                </c:forEach>
                </table>
            </div>
        </div>
        
    </main>
</body>
</html>