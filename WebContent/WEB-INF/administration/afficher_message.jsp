<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Administration</title>
    <c:import url="/inc/header.jsp" />
    <link href="<c:url value="/inc/cours.css"/> " rel="stylesheet" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
        
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/administration" />"><li class="chemin_li">Espace Administrateur</li></a>
                /
                 <a href="<c:url value="/adminMessages  " />"><li class="chemin_li">Messages ( ${ notification } nouveau${ notification gt 1 ? 'x' : '' } message${ notification gt 1 ? 's' : '' } )</li></a>
                /
                <li class="chemin_li">${ requestScope.message.titre } </li>
            </ul>
        </div>

        <div class="aff">
                <div class="aff_top">
                    <div class="aff_titre">
                        <span >${ message.titre }</span>
                    </div>
                    <div class="aff_type bold">
                        Email : <span>${ message.email }</span>
                    </div>
                    <div class="aff_type">
                        <span>
                         <a target="_top" href="mailto:${ message.email }">
                                        <i class="fa fa-reply" aria-hidden="true"></i>
                                    </a>
                                    
                                    <a href="
                                        <c:url value="/adminModificationMessage">
                                            <c:param name="id" value="${ message.id }" />
                                            <c:param name="vu" value="${ !message.vu ? true : false }" />
                                        </c:url>">
                                        ${ !message.vu ? '<i class="fa fa-envelope-open-o" aria-hidden="true"></i>' : '<i class="fa fa-envelope" aria-hidden="true"></i>' }
                                    </a>
                                    <a href="
                                        <c:url value="/adminSuppressionMessage">
                                            <c:param name="idMessage" value="${ message.id }" />
                                        </c:url>">
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                                    </a>
                        </span>
                    </div>
                    <div class="aff_date">
                        <span><joda:format value="${ message.date }" pattern="dd/MM/yyyy 'à' HH'h'mm" ></joda:format></span>
                    </div>
                </div>
                <div class="aff_contenue">
                    <span>${ message.message }</span>
                    <div class="aff_signe">
                        <span>Envoyer par <br><h3>${ message.nomPrenom }</h3></span>
                    </div>
                </div>
        </div>
    
    </main>
</body>
</html>