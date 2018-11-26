table 50100 "Interface"
{
    DataClassification = CustomerContent;
    Caption = 'Interface';
    
    fields
    {
        field(1;Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code'; 
        }
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }   
}