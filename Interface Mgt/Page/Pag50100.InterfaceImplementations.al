page 50100 "Interface Implementations"
{
    PageType = List;
    SourceTable = "Interface Implementation";
    Caption = 'Interface Implementations';
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Interface Code" ; "Interface Code")
                {
                    ApplicationArea = All;
                }
                field("Implementation Code"; "Implementation Code")
                {
                    ApplicationArea = All;
                }
                field("Codeunit ID";"Codeunit ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Setup';
                Image = Setup;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    InterfaceMgt : Codeunit "Interface Mgt.";
                begin
                    InterfaceMgt.OpenInterfaceImplementationSetupPage("Interface Code","Implementation Code");
                end;
            }
        }
    }
}