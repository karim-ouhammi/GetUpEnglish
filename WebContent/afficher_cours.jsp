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
                <a href="<c:url value="/cours.jsp"/>"><li class="chemin_li">Cours</li></a>
                /
                <li class="chemin_li">${ requestScope.cours.titre }</li>
            </ul>
        </div>

        <p><a href="
            <c:choose>
                <c:when test="${ requestScope.source eq 'adminCours' }">
                   <c:url value="/adminCours"/>
                </c:when>
                <c:when test="${ requestScope.source eq 'profil' }">
                   <c:url value="/historique"/>
                </c:when>
                <c:otherwise>
                  <c:url value="/cours.jsp"/>
                </c:otherwise>
            </c:choose>
        "><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></p>
        
        <c:if test="${ sessionScope.sessionUtilisateur.isAdmin() }">
            <c:if test="${ !empty requestScope.listeReponses }">
                <div class="btn_fix_div">
                    <a href="<c:url value="/adminAjouterQuestion">
                        <c:param name="idCours" value="${ requestScope.cours.id }" />
                    </c:url>" class="btn_fix_link"><i class="fa fa-plus"></i> <span class="btn_fix_text">Question</span></a>
                </div>
            </c:if>
        </c:if>
        
        <div class="aff">
			<div class="aff_top">
			    <div class="aff_titre">
			        <span ><c:out value="${ requestScope.cours.titre }"/></span>
			    </div>
			    <div class="aff_type">
			        <span><c:out value="${ requestScope.cours.categorie }"/></span>
			    </div>
			    <div class="aff_type">
			        <span>
			        <c:choose>
			                <c:when test="${ requestScope.cours.difficulte == 1 }">Facile</c:when>
			                <c:when test="${ requestScope.cours.difficulte == 2 }">Moyen</c:when>
			                <c:when test="${ requestScope.cours.difficulte == 3 }">Difficile</c:when>
			            </c:choose>
			        </span>
			    </div>
			    <div class="aff_date">
			        <span>Ajouté le <joda:format value="${  requestScope.cours.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></span>
			    </div>
			</div>
			<div class="aff_contenue">
			    <span>
			        ${ requestScope.cours.contenu }
			    </span>
			</div>
        </div>
        
        
        <c:if test="${ !empty requestScope.listeReponses }">
            <div class="aff">
                <div class="aff_top">
                    <div class="aff_titre">
	                    <span >
		                    Exerice
		                    <c:if test="${ sessionScope.sessionUtilisateur.isAdmin() }">
		                        <a href="<c:url value="/adminSuppressionExercice">
		                            <c:param name="id" value="${ requestScope.cours.id }"/>
		                        </c:url>">
		                            <i class="fa fa-trash-o" aria-hidden="true"></i>
		                        </a>
		                    </c:if>
	                    </span>
	                </div>
                </div>
                <c:if test="${ empty sessionScope.sessionUtilisateur }">
                    <p>Merci de vous <a href="<c:url value="/connexion"/>">connecter</a> ou vous <a href="<c:url value="/inscription"/>">inscrire</a> pour sauvegarder votre résultat.</p>
                </c:if> 
            </div>
            
            <div class="aff_contenue">
	            <form method="post" action="<c:url value="/correction"/>">
	                <!-- hidden id field -->
	                <input type="hidden" id="idCours" name="idCours" value="${ requestScope.cours.id }">
	                <!-- /.hidden id field -->
	            
	                <c:forEach items="${ requestScope.listeQuestions }" var="question" varStatus="status">
	                    <div>
	                        ${ status.count }. <img src="${ question.image }">
	                        <input type="hidden" id="${ status.count }_idQuestion" name="${ status.count }_idQuestion" value="<c:out value="${ question.id }"/>">
	                        <c:forTokens items="${ question.question }" delims=";" var="sousQuestion" varStatus="statusQuestion">
	                        
	                            <c:if test="${ statusQuestion.last }">
	                            
	                                <select name="${ status.count }" id=${ status.count }>
	                                    <option value="Je ne sais pas">Je ne sais pas</option>
	                                    <c:forEach items="${ requestScope.listeReponses }" var="reponse">
	                                        <option value="${ reponse.reponse }">
	                                             <c:out value="${ reponse.reponse }" />
	                                        </option>
	                                    </c:forEach>
	                                </select>
	                                
	                            </c:if>
	                            
	                            ${ sousQuestion }
	                        </c:forTokens>
	                        
	                        <c:if test="${ sessionScope.sessionUtilisateur.isAdmin() }">
	                            <a href="<c:url value="/adminSuppressionQuestion">
	                                <c:param name="id" value="${ question.id }"/>
	                            </c:url>">
	                                <i class="fa fa-trash-o" aria-hidden="true"></i>
	                            </a>
	                        </c:if>
	                    </div>
	                </c:forEach>
	                
	                <button type="submit">Correction</button>
	            </form>
            </div>  
        </c:if>
    </main>
    
    <c:import url="/inc/footer.jsp" />
    
</body>
</html>