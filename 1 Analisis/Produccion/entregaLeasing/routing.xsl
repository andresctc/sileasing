<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:dpfunc="http://www.datapower.com/extensions/functions"
	xmlns:func="http://exslt.org/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	extension-element-prefixes="dp"
	exclude-result-prefixes="dp dpfunc func fn"> 
	
 	<xsl:template match="/">
 				
 				<!-- Adicionar la transaccione a las variables para en rutar a qmanager-->
 					<xsl:variable name="tx_leasing"       select="'PELS-PELS'" />
 					<xsl:variable name="tx_giros"         select="'ED41-ED41'" />
 					<xsl:variable name="tx_segmentadores" select="'MCSE-MCSE'" />
                                        <!-- GP10683 - Novatec - INICIO-->
                                        <xsl:variable select="'KND0-KND0'" name="tx_billetera"/>
                                        <!-- GP10683 - Novatec - FIN-->
					<!-- GP10910 - Novatec - INICIO-->
					<!-- GP13273 - Debito Interbancario - se incluyen OZRI - OZRJ - OZRK -->
					<xsl:variable name="tx_bancamovil" select="'OZ54-OZA1-OZA2-OZA3-OZAU-OZS1-OZWD-OZY1-OZY2-OZY3-OZY4-OZY5-OZ01-OZ02-OZ03-OZ04-OZ06-OZ07-OZ08-OZ09-OZ0A-OZ0D-OZ0H-OZ32-OZD1-OZD5-OZD7-OZP2-OZPD-OZS4-OZAT-OZCJ-OZCK-OZCS-OZSE-OZST-OZTC-OZTE-OZTT-OZVT-OZR6-OZR9-OZW6-OZW8-OZW9-OZWC-OZRC-OZW0-OZW1-OZW2-OZW5-OZWP-OZDM-OZDN-OZDO-OZDP-OZDQ-OZTS-OZNC-OZSC-OZD0-OZQP-OZO0-OZH3-OZD8-OZD9-OZI2-OZI1-OZI3-OZI4-OZI5-OZVA-OZVB-OZCC-OZCD-OZRL-OZRP-OZRD-OZDE-OZDF-OZDG-OZDH-OZ13-OZCV-OZCS-OZ18-OZVD-OZVE-OZVF-OZVC-OZUP-OZUB-OZUF-OZUG-OZRK-OZ51-OZ52-OZ53-OZU7-OZQX-OZQY-OZC0-OZC2-OZC3-OZC5-OZC4-OZVH-OZC7-OZY8-OZY9-OZYB-OZYC-OZY6-OZY7-OZY0-OZYA-OZC9-OZRI-OZRJ-OZRK'" />
					<xsl:variable name="tx_billeteranuevo" select="''" />
					<!-- GP10910 - Novatec - FIN-->
                                      <xsl:variable name="tx_frontweb"      select="'IC09-IC10-IC11-ICDB-ICDC-ICDM'" />
 				<!-- Adicionar la transaccione a las variables para en rutar a qmanager-->
 				
 				
 				<xsl:variable name="codigo_tx" select="substring(normalize-space(/root/content),33,4)"/>
 				
 				<xsl:choose>
					<!-- GP10910 - Novatec - INICIO-->
					<xsl:when test="contains($tx_billeteranuevo,$codigo_tx)">
						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://QMPQSOA2/?RequestQueue=QRP.BILLSOA2.ENVIO.MQP4;ReplyQueue=QRP.BILLSOA2.RESP.QMPQSOA2                        ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://QMPQSOA2/?RequestQueue=QRP.BILLSOA2.ENVIO.MQP4;ReplyQueue=QRP.BILLSOA2.RESP.QMPQSOA2                         ;SetReplyTo=true'" />
					</xsl:when>
					<xsl:when test="contains($tx_bancamovil,$codigo_tx)">
						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://QMPQSOA2/?RequestQueue=QRP.BNSOA.ENVIO.MQP4.CO;ReplyQueue=QRP.BNSOA.RESP.QMPQSOA2.CO                        ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://QMPQSOA2/?RequestQueue=QRP.BNSOA.ENVIO.MQP4.CO;ReplyQueue=QRP.BNSOA.RESP.QMPQSOA2.CO                        ;SetReplyTo=true'" />
					</xsl:when>
					<!-- GP10910 - Novatec - FIN-->
		                        <!-- GP10683 - Novatec - INICIO-->
                                        <xsl:when test="starts-with($tx_billetera,$codigo_tx)"><dp:set-variable name="'var://service/routing-url'" value="'dpmq://QMCPSOA1/?RequestQueue=QRP.RETIC2.ENVIO.MQP4;ReplyQueue=QRP.RETIC2.RESP.QMCPSOA1 ;SetReplyTo=true'"/>
                                        <dp:set-variable name="'var://service/URL-out'" value="'dpmq://QMCPSOA1/?RequestQueue=QRP.RETIC2.ENVIO.MQP4;ReplyQueue=QRP.RETIC2.RESP.QMCPSOA1 ;SetReplyTo=true'"/></xsl:when>
                                        <!-- GP10683 - Novatec - FIN-->
 					<xsl:when test="starts-with($tx_leasing,$codigo_tx)">
						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://LEASmgr/?RequestQueue=QRP.LEASM.ENVIO.MQP4;ReplyQueue=QRP.LEASM.RESP.QMCPSOA1                         ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://LEASmgr/?RequestQueue=QRP.LEASM.ENVIO.MQP4;ReplyQueue=QRP.LEASM.RESP.QMCPSOA1                         ;SetReplyTo=true'" />  					   						
					</xsl:when>
					
					<xsl:when test="starts-with($tx_giros,$codigo_tx)">
   						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://BTSQmgr/?RequestQueue=QRP.ED.ENVIO.MQP4.CO;ReplyQueue=QRP.ED.RESP.QMCPBG01.CO                         ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://BTSQmgr/?RequestQueue=QRP.ED.ENVIO.MQP4.CO;ReplyQueue=QRP.ED.RESP.QMCPBG01.CO                         ;SetReplyTo=true'" />   
 					</xsl:when>																							
 	 		
 	 				<xsl:when test="starts-with($tx_segmentadores,$codigo_tx)">
						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://SEGQmgr/?RequestQueue=QRD.SEGFI.ENVIO.MQD4.CO;ReplyQueue=QRD.SEGFI.RESP.QMCDMC01.CO                          ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://SEGQmgr/?RequestQueue=QRD.SEGFI.ENVIO.MQD4.CO;ReplyQueue=QRD.SEGFI.RESP.QMCDMC01.CO                          ;SetReplyTo=true'" />  
					</xsl:when>									
					<xsl:when test="contains($tx_frontweb,$codigo_tx)">
						<dp:set-variable name="'var://service/routing-url'" value="'dpmq://FNTQmgr/?RequestQueue=QRP.SEGWS.ENVIO.MQP4.CO;ReplyQueue=QRP.SEGWS.RESP.QMCPIC01.CO                          ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://FNTQmgr/?RequestQueue=QRP.SEGWS.ENVIO.MQP4.CO;ReplyQueue=QRP.SEGWS.RESP.QMCPIC01.CO                          ;SetReplyTo=true'" />  
					</xsl:when>
					<xsl:otherwise>
					 	<dp:set-variable name="'var://service/routing-url'" value="'dpmq://BNTQmgr/?RequestQueue=QRP.BNET.ENVIO.MQP4.CO;ReplyQueue=QRP.BNET.RESP.QM1PBDC4.CO                         ;SetReplyTo=true'" />
						<dp:set-variable name="'var://service/URL-out'" value="'dpmq://BNTQmgr/?RequestQueue=QRP.BNET.ENVIO.MQP4.CO;ReplyQueue=QRP.BNET.RESP.QM1PBDC4.CO                         ;SetReplyTo=true'" />
					</xsl:otherwise>
					
				</xsl:choose>
								
				<dp:set-variable name="'var://context/gateway/codigo_tx'" value="concat('',$codigo_tx)"/>
									
	</xsl:template>
</xsl:stylesheet>