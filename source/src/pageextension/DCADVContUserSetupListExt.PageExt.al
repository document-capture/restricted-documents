namespace source.source;

pageextension 63042 "DCADV ContUser SetupList Ext" extends "CDC Continia User Setup List"
{
    layout
    {
        addbefore("Can Edit Approved Documents")
        {
            field("Restricted Document Access"; Rec."Restricted Document Access")
            {
                ApplicationArea = All;
            }
        }
    }
}