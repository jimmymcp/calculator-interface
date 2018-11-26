page 50101 "Calculator"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Calculator)
            {
                field(Operation; Operation)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        InterfaceImplementation: Record "Interface Implementation";
                        InterfaceMgt: Codeunit "Interface Mgt.";
                    begin
                        if InterfaceMgt.LookupInterfaceImplementation('TRIG', InterfaceImplementation) then
                            Operation := InterfaceImplementation."Implementation Code";
                    end;
                }
                field(Angle; Angle)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'Angle (rad)';
                }
                field(Result; Result)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    InterfaceMgt: Codeunit "Interface Mgt.";
                    AppIntegrationData: Codeunit "App Integration Data";
                    Handled: Boolean;
                begin
                    AppIntegrationData.SetIntegationData('Angle', Angle);
                    InterfaceMgt.InvokeInterfaceEvent('TRIG', Operation, 'Calculate', AppIntegrationData, Handled);
                    if Handled then
                        Result := AppIntegrationData.GetIntegrationDataDecimal('Result', 0)
                end;
            }
        }
    }

    var
        Operation: Code[20];
        Angle: Decimal;
        Result: Decimal;
}