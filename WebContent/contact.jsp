<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Connexion</title>
    <c:import url="/inc/header.jsp" />
    <link rel="stylesheet" href="<c:url value="/inc/inscription.css"/>" type="text/css" >
    <link rel="stylesheet" href="<c:url value="/inc/login.css"/>" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
    
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/index.jsp"/>"><li class="chemin_li">Get Up English</li></a>
                /
                <li class="chemin_li"> Contact</li>
            </ul>
        </div>
    
        <div class="ins-log">
            <div class="titre">
                <h1>Contact</h1>
            </div>
            <div class="form">
                <form action="<c:url value="/contact"/>" method="post">
                    
                    <c:if test="${ empty sessionUtilisateur }">
                    
	                    <div class="input_div">
	                        <label for="nom">Nom et Prénom</label>
	                        <input type="text" name="nom" id="nom" class="input" value="<c:out value="${ message.nomPrenom }"/>" maxlength="30">
	                    </div>
	                    <div class="input_div in_err">
	                        <h4 class="err">${ form.erreurs['nom'] }</h4>
	                    </div>
	                    
	                    <div class="input_div">
                            <label for="email">Adresse email</label>
                            <input type="text" name="email" id="email" class="input" value="<c:out value="${ message.email }" />" maxlength="60">
                        </div>
                        <div class="input_div in_err">
                            <h4 class="err">${ form.erreurs['email'] }</h4>
                        </div>
                    
                    </c:if>
                    
                    <div class="input_div">
                            <label for="titre">Titre</label>
                            <input type="text" name="titre" id="titre" class="input" value="<c:out value="${ message.titre }" />" maxlength="200">
                        </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['titre'] }</h4>
                    </div>
                    
                    <div class="input_div">
                            <label for="message">Message</label>
                            <textarea rows="10" cols="100" class="input" id="message" name="message" style="resize: vertical;">${ message.message }</textarea>
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['message'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <button type="submit" class="input">Envoyer</button>
                    </div>
                    <div class="input_div ${ empty form.erreurs ? 'in_suc' : 'in_err' }">
                        <h4 class="${ empty form.erreurs ? 'suc' : 'err' }"><c:out value="${ form.resultat }"/></h4>
                    </div>
                    
                </form>
            </div>
        </div>
    </main>
    
    <c:import url="/inc/footer.jsp" />
    
</body>
</html>