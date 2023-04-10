<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:dp="http://www.datapower.com/extensions" 
  extension-element-prefixes="dp">
  
  <xsl:output omit-xml-declaration="yes"/>  
  
  <dp:input-mapping href="binary-to-string.ffd" type="ffd"/>
 
  <xsl:template match="/">      
		             	  
      <xsl:copy-of select="."/>
      
  </xsl:template>
</xsl:stylesheet>