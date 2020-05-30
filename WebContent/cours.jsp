<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Cours</title>
    <c:import url="/inc/header.jsp" />
    <link rel="stylesheet" href="<c:url value="/inc/cours.css"/>" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
    
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/index.jsp"/>"><li class="chemin_li">Get Up English</li></a>
                /
                <li class="chemin_li">Cours</li>
            </ul>
        </div>
        
        <p>Veuillez cliquer sur un cours visualiser son contenu.</p>
        
        <div class="cours">
	        <c:forEach items="${ sessionScope.mapCours }" var="mapCours" varStatus="status">
                <a href="
	                <c:url value="/afficherCours">
	                    <c:param name="id" value="${ mapCours.key }" />
	                    <c:param name="source" value="cours" />
	                </c:url>
	                ">
	                <%-- <td class="c_text"> ${ status.count } </td> --%>
	                <div class="cours_div">
	                        <div class="cours_info">
	                        <div class="cours_categorie" >
	                           <span class="cours_text"><c:out value="${ mapCours.value.categorie }"/> </span>
	                        </div>
	                            <div class="cours_difficulte" >
	                            <span class="cours_text"><c:choose>
	                            <c:when test="${ mapCours.value.difficulte == 1 }">Facile</c:when>
	                            <c:when test="${ mapCours.value.difficulte == 2 }">Moyen</c:when>
	                            <c:when test="${ mapCours.value.difficulte == 3 }">Difficile</c:when>
	                            </c:choose></span>
	                         </div>
	                        <div class="cours_date" >
	                            <span class="cours_text">Ajouté le <joda:format value="${  mapCours.value.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></span>
	                        </div>
	                    </div>
	               
	                    <div class="cours_titre 
	                    ${ mapCours.value.difficulte eq 2 ? 'orrange' : '' }
	                    ${ mapCours.value.difficulte eq 3 ? 'red' : '' }
	                    " >
	                        <span>
					<c:choose>
						<c:when test="${ mapCours.value.titre.length() gt 25 }">
						    ${ mapCours.value.titre.substring(0,25) } . . .
						</c:when>
						<c:otherwise>
						    ${ mapCours.value.titre }
						</c:otherwise>
					</c:choose>
	                        </span>
	                    </div>
	                </div>                        
                </a>     
	        </c:forEach>
        </div>
    </main>
    
    <c:import url="/inc/footer.jsp" />
    
</body>
</html>
