table 50101 "Interface Implementation"
{
    DataClassification = CustomerContent;
    Caption = 'Interface Implementation';
    DrillDownPageId = 50100;
    LookupPageId = 50100;
    
    fields
    {
        field(1;"Interface Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interface Code';
        }
        field(2; "Implementation Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Implementation Code';
        }
        field(3; "Codeunit ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Codeunit ID';
        }
        field(4; "Setup Page ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Setup Page ID';
        }
    }
    
    keys
    {
        key(PK; "Interface Code", "Implementation Code")
        {
            Clustered = true;
        }
    }

    var
        MustBeTempErr : Label 'Only temporary records should be inserted into %1';

    procedure AddNewEntry(InterfaceCode : Code[20]; ImplementationCode : Code[20]; CodeunitID : Integer; SetupPageID : Integer)
    begin
        if not IsTemporary() then
            Error(MustBeTempErr,TableCaption());

        if Get(InterfaceCode,ImplementationCode) then
            Delete();

        Init();

       "Implementation Code" := ImplementationCode;
       "Interface Code" := InterfaceCode;
       "Codeunit ID" := CodeunitID;
       "Setup Page ID" := SetupPageID;
       Insert(); 
    end;
}