<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<script type="text/javascript" src="/swfobject.js"></script>
		<script type="text/javascript">
			swfobject.registerObject("myId", "9.0.0", "expressInstall.swf");
		</script>
		<title>Vota��o ${votacao.id} - Sistema Vota��o</title>
		<script>
			var clicado = 0;
			function votar(idVotacao, idCandidato) {
				if (clicado == 0) {
					clicado = 1;
					document.getElementById('idVotacao').value = idVotacao;
					document.getElementById('idCandidato').value = idCandidato;

					document.frmVotacao.submit();
				} else {
					alert('Aguarde, opera��o em processamento');
				}
				return false;
			}
		</script>
	</head>
	<body>
		<jsp:include page="/menu.jsp" />
		
		<h1 align="center">Vota��o ${votacao.id}</h1>
		
		<c:choose>
			<c:when test="${votacao.encerrada}">
				<h2 align="center">Vota��o '${votacao.descricao}' Encerrada</h2>
			</c:when>
			<c:otherwise>
			
				<h2 align="center">${votacao.descricao}</h2>
				<h3 align="center">${msg}</h3>
				<h4 align="center">
					In�cio da vota��o : <fmt:formatDate value="${votacao.periodo.dataInicio}" pattern="dd/MM/yyyy HH:mm:ss"/>
				</h4>
				<h4 align="center">
					T�rmino da vota��o : <fmt:formatDate value="${votacao.periodo.dataFim}" pattern="dd/MM/yyyy HH:mm:ss"/>
				</h4>
				
				<h4 align="center">Para votar em um candidato, clique em 'Votar' ao lado do candidato</h4>
				
				<table align="center">
					<tr>
						<td>
				
							<ul>
								<c:forEach var="candidado" items="${votacao.candidatos}">
									<li>
									
										<div>	
											<object id="myId" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="300" height="120">
												<param name="movie" value="test.swf" />
								        		<!--[if !IE]>-->
												<object type="application/x-shockwave-flash" data="/flowplayer-3.2.14.swf" width="300" height="120">
												<!--<![endif]-->
												<div>
													<h1>Alternative content</h1>
													<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
												</div>
												<!--[if !IE]>-->
												</object>
												<!--<![endif]-->
											</object>
										</div>

										${candidado.id} - ${candidado.descricao} - Votos : ${candidado.numeroVotos}
										<a href="#" onclick="javascript:votar(${votacao.id}, ${candidado.id});">Votar</a>
									</li>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>
		
		<form id="frmVotacao" name="frmVotacao" action="/SistemaVotacao/ConclusaoVotacaoServlet">
			<input type="hidden" id="idVotacao" name="idVotacao" />
			<input type="hidden" id="idCandidato" name="idCandidato" />
		</form>
		
	</body>
</html>