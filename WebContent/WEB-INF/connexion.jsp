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
        <div class="ins-log">
            <div class="titre">
                <h1>Connexion</h1>
            </div>
            <div class="form">
                <form action="<c:url value="connexion"/>" method="post">
                
                    <div class="input_div">
                        <label for="email">Email</label>
                        <input type="text" name="email" id="email" class="input" value="<c:out value="${ utilisateur.email }" />">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['email'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="motDePasse">Mot de pass</label>
                        <input type="password" name="motDePasse" id="motDePasse" class="input">
                    </div>
                    <div class="input_div in_err">
                            <h4 class="err">${ form.erreurs['motDePasse'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <button type="submit" class="input">Connexion</button>
                    </div>
                    <div class="input_div ${ empty form.erreurs ? 'in_suc' : 'in_err' }">
                        <h4 class="${ empty form.erreurs ? 'suc' : 'err' }"><c:out value="${ form.resultat }"/></h4>
                    </div>
                    
                    <div class="input_div">
                        <h3 class="dernier_text">
                            Vous n'avez pas de compte ?<a href="<c:url value="/inscription"/>"> S'inscrire.</a>.
                        </h3>
                    </div>
                    
                </form>
            </div>
        </div>
        
    </main>
</body>
</html>