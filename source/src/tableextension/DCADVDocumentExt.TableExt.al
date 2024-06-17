namespace source.source;

tableextension 63041 "DCADV Document Ext" extends "CDC Document"
{
    fields
    {
        field(63040; "Restricted Document"; Boolean)
        {
            Caption = 'Restricted Document';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RestrictedDocumentMgt: Codeunit "DCADV Restricted Document Mgt.";
            begin
                RestrictedDocumentMgt.ValidateDocumentRestrictedAccess(Rec, true);
            end;
        }
    }
}
