namespace source.source;

pageextension 63041 "DCADV ContUser SetupCard Ext" extends "CDC Continia User Setup Card"
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
