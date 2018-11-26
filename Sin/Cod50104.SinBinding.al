codeunit 50104 "Sin Binding"
{
    trigger OnRun()
    var
        InterfaceMgt : Codeunit "Interface Mgt.";
        SinCalculation : Codeunit "Sin Calculation";
    begin
        BindSubscription(SinCalculation);
        InterfaceMgt.SetInterfaceCodeunit(SinCalculation);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Mgt.", 'OnRegisterInterface', '', false, false)]
    local procedure OnRegisterInterface(var InterfaceImplementationBuffer: Record "Interface Implementation" temporary)
    begin
        InterfaceImplementationBuffer.AddNewEntry('TRIG','SIN',Codeunit::"Sin Binding",0);
    end;
}