//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.05.13 at 06:31:23 PM FET 
//


package generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{}range"/>
 *         &lt;element ref="{}aimRange"/>
 *         &lt;element ref="{}hasCage"/>
 *         &lt;element ref="{}hasOptics"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "range",
    "aimRange",
    "hasCage",
    "hasOptics"
})
@XmlRootElement(name = "TTP")
public class TTP {

    @XmlElement(required = true)
    protected String range;
    protected int aimRange;
    protected boolean hasCage;
    protected boolean hasOptics;

    /**
     * Gets the value of the range property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRange() {
        return range;
    }

    /**
     * Sets the value of the range property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRange(String value) {
        this.range = value;
    }

    /**
     * Gets the value of the aimRange property.
     * 
     */
    public int getAimRange() {
        return aimRange;
    }

    /**
     * Sets the value of the aimRange property.
     * 
     */
    public void setAimRange(int value) {
        this.aimRange = value;
    }

    /**
     * Gets the value of the hasCage property.
     * 
     */
    public boolean isHasCage() {
        return hasCage;
    }

    /**
     * Sets the value of the hasCage property.
     * 
     */
    public void setHasCage(boolean value) {
        this.hasCage = value;
    }

    /**
     * Gets the value of the hasOptics property.
     * 
     */
    public boolean isHasOptics() {
        return hasOptics;
    }

    /**
     * Sets the value of the hasOptics property.
     * 
     */
    public void setHasOptics(boolean value) {
        this.hasOptics = value;
    }

}
