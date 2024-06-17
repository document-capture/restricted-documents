namespace source.source;

codeunit 63040 "DCADV Restricted Document Mgt."
{
    procedure IsRestrictedDocument(Document: Record "CDC Document"): Boolean
    begin
        exit(Document."Restricted Document");
    end;

    procedure UserHasAccessToDocument(DocumentNo: Code[20]): Boolean
    var
        Document: Record "CDC Document";
        UserSetup: Record "CDC Continia User Setup";
    begin
        if not Document.Get(DocumentNo) then
            exit(false);

        if not Document."Restricted Document" then
            exit(true);

        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup."Restricted Document Access");
    end;

    procedure ValidateDocumentRestrictedAccess(var Document: Record "CDC Document"; ShowErrorIfNoPermission: Boolean)
    var
        UserSetup: Record "CDC Continia User Setup";
        HasPermission: Boolean;
    begin
        if UserSetup.Get(UserId) then
            HasPermission := UserSetup."Restricted Document Access";

        if (not HasPermission) then
            if ShowErrorIfNoPermission then
                Error(NoAccessToDocumentErrorMsg)
            else
                Error('');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDC Doc. File Events", 'OnGetFile', '', false, false)]
    local procedure DocFileEvents_OnGetFile(FileName: Text[1024]; Company: Text[50]; DocumentNo: Code[20]; FileType: Integer; var TempFile: Record "CDC Temp File" temporary; var Result: Boolean; var Handled: Boolean)
    begin

        if not UserHasAccessToDocument(DocumentNo) then begin
            Clear(TempFile);
            Message(NoAccessToDocumentErrorMsg);
            Handled := true;
        end;

    end;

    var
        FileTypes: Option Tiff,Pdf,Miscellaneous,"E-Mail","Document Page",Html,"Xml (Original)","Xml (Trimmed)";
        NoAccessToDocumentErrorMsg: Label 'You do not have permissions to access this restricted document! Ask your administrator or manager.', Comment = 'Message presented to the user, if he has no access to document', Locked = false;
}

