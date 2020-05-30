<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GetUpEnglish - Administration</title>
    <c:import url="/inc/header.jsp" />
    <link rel="stylesheet" href="<c:url value="/inc/inscription.css"/>" type="text/css" >
    <link href="<c:url value="/inc/ajt_cours.css"/>" rel="stylesheet"  type="text/css" >
    <link href="<c:url value="/inc/utilisateur.css"/> " rel="stylesheet" type="text/css" >
    
    <!-- froala HTML text editor -->
    <link href='https://cdn.jsdelivr.net/npm/froala-editor@3.1.0/css/froala_editor.pkgd.min.css' rel='stylesheet' type='text/css' />
    <script type='text/javascript' src='https://cdn.jsdelivr.net/npm/froala-editor@3.1.0/js/froala_editor.pkgd.min.js'></script>
    
    <!-- TinyMCE -->
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>tinymce.init({selector:'textarea',body_class: 'textarea'});</script>
</head>
<body>
     <!--Menu -->
    <c:import url="/inc/menu.jsp" />
    
    <main>
    
        <div class="chemin">
            <ul class="chemin_ul">
                <a href="<c:url value="/administration" />"><li class="chemin_li">Espace Administrateur</li></a>
                /
                <a href="<c:url value="/adminCours" />"><li class="chemin_li">Cours</li></a>
                /
                <li class="chemin_li">Ajouter Cours</li>
            </ul>
        </div>
                
        <p><a href="<c:url value="/adminCours"/>"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> Retour</a></p>
        
        <div class="ins-log">
            <div class="titre">
                <h1>Ajouter un nouveau Cours</h1>
            </div>
            
            <div class="form">
                <form action="<c:url value="/adminAjouterCours"/>" method="post">
                    
                    <div class="input_div">
                            <label>Titre</label>
                            <input type="text" name="titre" class="input" value="<c:out value="${ cours.titre }" />">
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['titre'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label>Categorie</label>
                        <div class="genre_div">
                        <select name="categorie" id="categorie">
                            <option value="1" ${ cours.categorie eq 'Grammaire' ? 'selected' : '' }>Grammaire</option>
                            <option value="2" ${ cours.categorie eq 'Orthographe' ? 'selected' : '' }>Orthographe</option>
                            <option value="3" ${ cours.categorie eq 'Vocabulaire et Lexique' ? 'selected' : '' }>Vocabulaire et Lexique</option>
                        </select>
                        </div>
                    </div>

                    <div class="input_div">
                        <label>Difficulté</label>
                        <div class="genre_div">
                        <select name="difficulte" id="difficulte">
                            <option value="1" ${ cours.difficulte eq 1 ? 'selected' : '' }>Facile</option>
                            <option value="2" ${ cours.difficulte eq 2 ? 'selected' : '' }>Moyen</option>
                            <option value="3" ${ cours.difficulte eq 3 ? 'selected' : '' }>Difficile</option>
                        </select>
                        </div>
                    </div>
                    
                    <label>Ce cours possédera des exercices ?</label>
                    <input type="radio" id="existanceDesExercices" name="existanceDesExercices" value="pasReponses" checked/>Non
                    <input type="radio" id="existanceDesExercices" name="existanceDesExercices" value="reponses"  />Oui
                    
                    <div id="pasReponses">
                    </div>
                    
                    <div id="reponses">
                        <div class="input_div">
	                        <label>Réponses</label>
	                        <input type="text" id="reponses" name="reponses" class="input" placeholder="Exemple: Vrai;Faux">
                        </div>
                        <p><span class="require">Utilisez les points-virgules (;) comme séparateurs</span></p>
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['reponses'] }</h4>
                    </div>
                    
                    <div class="input_div">
                        <label>Contenu</label>
                        <!--<textarea id="froala-editor" name="contenu" cols="30" rows="30" style="resize: vertical;"><c:out value="${ cours.contenu }"/></textarea>-->
                        <textarea name="contenu" cols="10" rows="30" style="resize: vertical;"><c:out value="${ cours.contenu }"/></textarea>
                    </div>
                    <div class="input_div in_err">
                        <h4 class="err">${ form.erreurs['contenu'] }</h4>
                    </div>
                
                    <div class="input_div ${ empty form.erreurs ? 'in_suc' : 'in_err' }">
                    <h4 class="${ empty form.erreurs ? 'suc' : 'err' }"><c:out value="${ form.resultat }"/></h4>
                    </div>
                    <div class="input_div">
                        <input type="submit" name="ajouter" class="input" value="Ajouter">
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script> 
	<%-- Petite fonction jQuery permettant l'affichage des champs de réponses, au clic sur le bouton radio. --%>
	<script>
		jQuery(document).ready(function(){
		    /* 1 - Au lancement de la page, on cache le bloc des réponses */
		    $("div#reponses").hide();
		    /* 2 - Au clic sur un des deux boutons radio "existanceDesExercices", on affiche le bloc d'éléments correspondant */
		    jQuery('input[name=existanceDesExercices]:radio').click(function(){
		        $("div#pasReponses").hide();
		        $("div#reponses").hide();
		        var divId = jQuery(this).val();
		        $("div#"+divId).show();
		    });
		});
	</script>
    
    <script>
    new FroalaEditor('textarea#froala-editor')
    </script>

</body>
</html>