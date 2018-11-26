codeunit 50106 "Tan Binding"
{
    trigger OnRun()
    var
        InterfaceMgt : Codeunit "Interface Mgt.";
        TanCalculation : Codeunit  "Tan Calculation";
    begin
        BindSubscription(TanCalculation);
        InterfaceMgt.SetInterfaceCodeunit(TanCalculation);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Mgt.", 'OnRegisterInterface', '', false, false)]
    local procedure OnRegisterInterface(var InterfaceImplementationBuffer: Record "Interface Implementation" temporary)
    begin
        InterfaceImplementationBuffer.AddNewEntry('TRIG','TAN',Codeunit::"Tan Binding",0);
    end;
}