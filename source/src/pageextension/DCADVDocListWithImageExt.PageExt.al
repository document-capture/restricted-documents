namespace source.source;

pageextension 63043 "DCADV DocList WithImage Ext" extends "CDC Document List With Image"
{
    layout
    {
        addbefore(OK)
        {
            field("Restricted Document"; Rec."Restricted Document")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        RestrictedDocumentMgt: Codeunit "DCADV Restricted Document Mgt.";
    begin
        if not RestrictedDocumentMgt.UserHasAccessToDocument(Rec."No.") then begin
            CurrPage.CaptureUI.PAGE.ClearImage;
            CurrPage.Header.PAGE.ClearPage;
        end
    end;
}
