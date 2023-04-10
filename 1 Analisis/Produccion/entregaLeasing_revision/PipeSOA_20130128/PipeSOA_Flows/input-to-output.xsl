<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:func="http://exslt.org/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	
	<xsl:output encoding="UTF-8" indent="no" method="xml" version="1.0"></xsl:output> 
		
 	<xsl:template match="/">
		<xsl:copy-of select="/requestTransaccion/trama/*"></xsl:copy-of>		
	</xsl:template>
	
</xsl:stylesheet>