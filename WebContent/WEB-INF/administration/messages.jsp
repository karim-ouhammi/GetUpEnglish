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
                <li class="chemin_li">Messages ( ${ notification } nouveau${ notification gt 1 ? 'x' : '' } message${ notification gt 1 ? 's' : '' } )</li>
            </ul>
        </div>

        <div></div>

        <div class="contenue overflow-auto">
            <div  class="c_tab">
                <table>
                    <tr class="c_item_1">
                        <td class="c_text_email"> Tittre </td>
                        <td class="c_text"> Nom et Prénom </td>
                        <td class="c_text"> Envoyé le </td>
                        <td class="c_text"> Action </td>

                    </tr>

                    <c:forEach items="${ sessionScope.messages }" var="mapMessages" varStatus="status">
                        <tr class="c_item">
                            <td class="c_text">
                                <a title="${ mapMessages.value.titre }" href="
                                    <c:url value="/adminAfficherMessage">
                                        <c:param name="idMessage" value="${ mapMessages.key }" />
                                    </c:url>">
	                                ${ !mapMessages.value.vu ? '<strong>' : '' }
	                                ${ mapMessages.value.titre }
	                                ${ !mapMessages.value.vu ? '</strong>' : '' }
                                </a>
                            </td>
                            <td class="c_text"> ${ mapMessages.value.nomPrenom } </td>
                            <td class="c_text"> <joda:format value="${ mapMessages.value.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></td>
                            <td class="c_text">
                                    <a target="_top" href="mailto:${ mapMessages.value.email }">
                                        <i class="fa fa-reply" aria-hidden="true"></i>
                                    </a>
                                    &nbsp;&nbsp;
                                    <a href="
                                        <c:url value="/adminModificationMessage">
                                            <c:param name="id" value="${ mapMessages.key }" />
                                            <c:param name="vu" value="${ !mapMessages.value.vu ? true : false }" />
                                        </c:url>">
                                        ${ !mapMessages.value.vu ? '<i class="fa fa-envelope-open-o" aria-hidden="true"></i>' : '<i class="fa fa-envelope" aria-hidden="true"></i>' }
                                    </a>
                                    &nbsp;&nbsp;
                                    <a href="
                                        <c:url value="/adminSuppressionMessage">
                                            <c:param name="idMessage" value="${ mapMessages.key }" />
                                        </c:url>">
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
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