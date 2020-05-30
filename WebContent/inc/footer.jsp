<%@ page pageEncoding="UTF-8" %>

<div class="footer">
    <div class="contenue_footer">

        <div class="section_footer Apropos">
            <h2 class="logo_text">À propos</h2>
            <p>
                Get Up English, site entièrement gratuit pour apprendre ou réviser l'anglais.</br>
                TOUS NIVEAUX : débutants, intermédiaire et avancé.
            </p>
            <div class="comunication">
                <a href="#"><span><i class="fa fa-facebook"></i></span></a>
                <a href="#"><span><i class="fa fa-twitter"></i></span></a>
                <a href="#"><span><i class="fa fa-instagram"></i></span></a>
                <a href="#"><span><i class="fa fa-youtube-play"></i></span></a>
            </div>
        </div>
        <div class="section_footer Addresses">
            <h2 class="logo_text">Adresse</h2>
            <div class="tel">
                <span><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;
	                Faculté des sciences</br>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Département informatique</br>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Meknès, Maroc
                </span>
            </div>
                
            <div class="tel">
                <span><i class="fa fa-phone"></i> &nbsp; (+212) 06 07 08 09 </span>
            </div>
            <div class="email_ad">
                <span><i class="fa fa-envelope"></i> &nbsp; contact@getupenglish.com </span>
            </div>
        </div>
        <div class="section_footer contact-form">
            <h2>Contact</h2>
            <div class="form">
                <form action="<c:url value="/contact"/>" method="post">
                
	                <c:if test="${ empty sessionUtilisateur }">
	                    <div class="email_cn">
	                        <div class="text">Nom et Prénom</div>
	                        <input type="text" name="nom" id="nom" class="input" value="<c:out value="${ message.nomPrenom }"/>" maxlength="30">
                            <div class="text">Email</div>
                            <input type="text" name="email" id="email" class="input" value="<c:out value="${ message.email }" />" maxlength="60">
	                    </div>

	                </c:if>
                    
                    <div class="email_cn">
                        <div class="text">Titre</div>
                        <input type="text" name="titre" id="titre" class="input" value="<c:out value="${ message.titre }" />" maxlength="60">
                    </div>

                    
                    <div class="mes_cn">
                        <div class="text">Message</div>
                        <textarea rows="4" cols="35" id="message" name="message" style="resize: vertical;">${ message.message }</textarea>
                    </div>
                    
                    <div class="mes_cn">
                        <button class="envoyer" type="submit">Envoyer</button>
                    </div>
                    
                </form>
            </div>
        </div>

    </div>
    <div class="fin_footer">
        Tout droit réservés © GetUpEnglish.com - 2020
    </div>
</div>