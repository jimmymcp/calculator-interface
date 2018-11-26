codeunit 50102 "Cos Binding"
{
    trigger OnRun()
    var
        InterfaceMgt : Codeunit "Interface Mgt.";
        CosCalculation : Codeunit "Cos Calculation";
    begin
        BindSubscription(CosCalculation);
        InterfaceMgt.SetInterfaceCodeunit(CosCalculation);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Mgt.", 'OnRegisterInterface', '', false, false)]
    local procedure OnRegisterInterface(var InterfaceImplementationBuffer: Record "Interface Implementation" temporary)
    begin
        InterfaceImplementationBuffer.AddNewEntry('TRIG','COS',Codeunit::"Cos Binding",0);
    end;
}