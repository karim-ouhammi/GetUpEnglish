<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Inscription</title>
    <c:import url="/inc/header.jsp" />
    <link rel="stylesheet" href="<c:url value="/inc/inscription.css"/>" type="text/css" >
</head>
<body>
    <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
        <div class="ins-log">
            <div class="titre">
                <h1>Inscription</h1>
            </div>
            <div class="form">
                <form action="<c:url value="/inscription"/>" method="post">

                    <div class="input_div">
                        <label for="email">Email <span class="require">*</span></label>
                        <input type="text" name="email" id="email" class="input" value="<c:out value="${ utilisateur.email }" />" maxlength="60">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['email'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="motDePasse">Mot de pass <span class="require">*</span></label>
                        <input type="password" name="motDePasse" id="motDePasse" class="input" >
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['motDePasse'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="confirmation">Confirmer le mot de pass <span class="require">*</span></label>
                        <input type="password" name="confirmation" id="confirmation" class="input" >
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['confirmation'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="nom">Nom <span class="require">*</span></label>
                        <input type="text" name="nom" id="nom" class="input" value="<c:out value="${ utilisateur.nom }" />" maxlength="20">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['nom'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="prenom">Prénom <span class="require">*</span></label>
                        <input type="text" name="prenom" id="prenom" class="input" value="<c:out value="${ utilisateur.prenom }" />" maxlength="20">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['prenom'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="age">Âge <span class="require">*</span></label>
                        <input type="text" name="age" id="age" class="input" value="<c:out value="${ utilisateur.age }" />" maxlength="2">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['age'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label for="telephone">Téléphone <span class="require">*</span></label>
                        <input type="text" name="telephone" id="telephone" class="input" value="<c:out value="${ utilisateur.telephone }" />" maxlength="10">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['telephone'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <span class="require">*</span> Champ obligatoire. 
                    </div>
                    
                    <div class="input_div">
                        <button type="submit" class="input">Inscription</button>
                    </div>
                    <div class="input_div ${ empty form.erreurs ? 'in_suc' : 'in_err' }">
                        <h4 class="${ empty form.erreurs ? 'suc' : 'err' }"><c:out value="${ form.resultat }"/></h4>
                    </div>

                    <div class="input_div">
                        <h3 class="dernier_text">
                            Si vous êtes déjà inscrit, vous pouvez vous <a href="<c:url value="/connexion"/>">identifier ici</a>.
                        </h3>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>