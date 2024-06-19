component persistent="true" table="hobbies" {
    property name="hid" fieldtype="id" generator="identity";
    property name="hobby";
    property name="contact" fieldtype="many-to-one" cfc="ormContactFunction" fkcolumn="contactId";

}
