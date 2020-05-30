<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                <a href="
                <c:url value="/afficherCours">
                    <c:param name="id" value="${ requestScope.cours.id }" />
                </c:url>
                ">
                    <li class="chemin_li">${ requestScope.cours.titre }</li>
                </a>
                /
                <li class="chemin_li">Correction</li>
            </ul>
        </div>
        
        <h1>
            
        </h1>

        <p><a href="
            <c:url value="/afficherCours">
                <c:param name="id" value="${ requestScope.cours.id }" />
            </c:url>
        "><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></p>
        
        <div class="aff">
            <div class="aff_top">
                <div class="aff_titre">
                    <span ><c:out value=" Correction : ${ requestScope.cours.titre }"/></span>
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
        </div>
        
        <div class="aff_contenue">      
            <c:forEach items="${ requestScope.listeQuestions }" var="question" varStatus="status">
                <div>
                    ${ status.count }. <img src="${ question.image }">
                    <input type="hidden" id="${ status.count }_idQuestion" name="${ status.count }_idQuestion" value="<c:out value="${ question.id }"/>">
                    <c:forTokens items="${ question.question }" delims=";" var="sousQuestion" varStatus="statusQuestion">
                        <c:if test="${ statusQuestion.last }">
                           
                           <c:choose>
                                <c:when test="${ requestScope.reponsesUtilisateur[question.id] eq question.reponse }" >
                                    <font color="#008000">
                                        ${ requestScope.reponsesUtilisateur[question.id] } <i class="fa fa-check" aria-hidden="true"></i>
                                    </font>
                                </c:when>
                                <c:otherwise>
                                    <font color="#FF0000">
                                        <del style="text-decoration: line-through;">
                                           ${ requestScope.reponsesUtilisateur[question.id] }
                                        </del>
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </font>
                                    <font color="#2244A7">
                                        ${ question.reponse }
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                    </font>
                                </c:otherwise>
                           </c:choose>
                        </c:if>
                        ${ sousQuestion }
                    </c:forTokens>
                </div>
            </c:forEach>
            
        
            <c:if test="${ empty sessionScope.sessionUtilisateur }">
                <p>Merci de vous <a href="<c:url value="/connexion"/>">connecter</a> pour sauvegarder votre résultat.</p>
            </c:if>
            
            <div>
                Votre note : 
                <font size="6" color="#FF0000">
                   <strong>
                       <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.coursUtilisateur.note }" />/20
                    </strong>
                </font>
            </div>
        
        </div>
        
        <div class="aff_contenue">
            Résultats des ${ requestScope.stats.nombreParticipants } personnes qui ont passé ce test :</br>
            <table style="margin-left:auto; margin-right:auto;">
                <tr>
                    <td colspan="2" style="text-align: center;">
                        Moyenne : <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.moyenne }" />/20
                    </td>
                </tr>
                <tr>
                    <td>
                        <c:if test="${ requestScope.coursUtilisateur.note < 5 }"><font color="#FF0000">[Vous]</font></c:if>
                        de 0 à 4,9/20 :
                    </td>
                    <td>
                        <table><tr style="background-color:#2244A7;"><td style="width:${ requestScope.stats.pourcentage0_4 * 3 }px;height:6px;"></td></tr></table>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.pourcentage0_4 }" />%
                    </td>
                </tr>
                
                <tr>
                   <td>
                    <c:if test="${ requestScope.coursUtilisateur.note < 10 and requestScope.coursUtilisateur.note >= 5  }"><font color="#FF0000">[Vous]</font></c:if>
                        de 5 à 9,9/20 :
                    </td>
                    <td>
                        <table><tr style="background-color:#2244A7;"><td style="width:${ requestScope.stats.pourcentage5_9 * 3 }px;height:6px;"></td></tr></table>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.pourcentage5_9 }" />%
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <c:if test="${ requestScope.coursUtilisateur.note < 15 and requestScope.coursUtilisateur.note >= 10  }"><font color="#FF0000">[Vous]</font></c:if>
                        de 10 à 14,9/20 :
                    </td>
                    <td>
                        <table><tr style="background-color:#2244A7;"><td style="width:${ requestScope.stats.pourcentage10_14 * 3 }px;height:6px;"></td></tr></table>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.pourcentage10_14 }" />%
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <c:if test="${ requestScope.coursUtilisateur.note < 20 and requestScope.coursUtilisateur.note >= 15  }"><font color="#FF0000">[Vous]</font></c:if>
                        de 15 à 19,9/20 :
                    </td>
                    <td>
                        <table><tr style="background-color:#2244A7;"><td style="width:${ requestScope.stats.pourcentage15_19 * 3 }px;height:6px;"></td></tr></table>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.pourcentage15_19 }" />%
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <c:if test="${ requestScope.coursUtilisateur.note == 20 }"><font color="#FF0000">[Vous]</font></c:if>
                        Parfait (20/20) :
                    </td>
                    <td>
                        <table><tr style="background-color:#2244A7;"><td style="width:${ requestScope.stats.pourcentage20 * 3 }px;height:6px;"></td></tr></table>
                    </td>
                    <td>
                        <fmt:formatNumber type="number" maxIntegerDigits="3"  maxFractionDigits="2" value="${ requestScope.stats.pourcentage20 }" />%
                    </td>
                </tr>
            </table>
        </div>
    </main>
    
    <c:import url="/inc/footer.jsp" />
    
</body>
</html>