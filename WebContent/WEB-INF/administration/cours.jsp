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
                <li class="chemin_li">Cours</li>
            </ul>
        </div>
                
        <div class="btn_fix_div">
            <a href="<c:url value="/adminAjouterCours"/>" class="btn_fix_link"><i class="fa fa-plus"></i> <span class="btn_fix_text">Cours</span></a>
        </div>
        
        <div class="contenue">
            
            <c:if test="${ !empty form.resultat }">
                <p><c:out value="${ form.resultat }" escapeXml="false"/></p>
            </c:if>
        
            <div  class="c_tab">
                <table>
                    <tr class="c_item_1">
                        <td class="c_text">#</td>
                        <td class="c_text_email">Titre</td>
                        <td class="c_text">Categorie</td>
                        <td class="c_text">Difficulté</td>
                        <td class="c_text">Ajouté le</td>
                        <td class="c_text">Action</td>
                    </tr>
                    
                    <c:forEach items="${ sessionScope.mapCours }" var="mapCours" varStatus="status">
                        <tr class="c_item">
                            <td class="c_text"> ${ status.count } </td>
                            <td class="c_text_email">
                                <a href="
                                    <c:url value="/afficherCours">
                                        <c:param name="id" value="${ mapCours.key }" />
                                        <c:param name="source" value="adminCours" />
                                    </c:url>
                                ">
                                    <c:out value="${ mapCours.value.titre }"/>
                                </a>
                            </td>
                            <td class="c_text"> <c:out value="${ mapCours.value.categorie }"/> </td>
                            <td class="c_text">
                                <c:choose>
	                                <c:when test="${ mapCours.value.difficulte == 1 }">Facile</c:when>
	                                <c:when test="${ mapCours.value.difficulte == 2 }">Moyen</c:when>
	                                <c:when test="${ mapCours.value.difficulte == 3 }">Difficile</c:when>
                                </c:choose>
                            </td>
                            <td class="c_text">
                                <joda:format value="${  mapCours.value.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format>
                            </td>
                            <td class="c_text">
	                            <a href="
	                                <c:url value="/adminSuppressionCours">
	                                    <c:param name="id" value="${ mapCours.key }" />
	                                </c:url>">
	                                <i class="fa fa-trash-o" aria-hidden="true"></i>
	                            </a>&nbsp;&nbsp;
	                            <a href="
                                    <c:url value="adminModificationCours">
                                        <c:param name="id" value="${ mapCours.key }" />
                                    </c:url>">
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        
    </main>

</body>
</html>