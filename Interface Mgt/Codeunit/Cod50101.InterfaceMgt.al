codeunit 50101 "Interface Mgt."
{
    SingleInstance = true;

    var
        Interface: Record Interface temporary;
        InterfaceImplementation: Record "Interface Implementation" temporary;
        InterfaceCodeunit: Variant;
        NoInterfaceCodeunitErr: Label 'No interface codeunit was set by codeunit %1 (Interface %2, Implementation %3)';
        NoInterfaceImplementationErr: Label 'Could not find an installed implementation of interface %1';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Triggers", 'OnCompanyOpen', '', true, true)]
    local procedure OnCompanyOpen()
    begin
        RegisterInterfaces();
    end;

    procedure RegisterInterfaces()
    begin
        Interface.DeleteAll();
        OnRegisterInterface(InterfaceImplementation);
        if InterfaceImplementation.FindSet() then
            repeat
                Interface.Code := InterfaceImplementation."Interface Code";
                Interface.Insert();

                InterfaceImplementation.SetRange("Interface Code",InterfaceImplementation."Interface Code");
                InterfaceImplementation.FindLast();
                InterfaceImplementation.SetRange("Interface Code");
            until InterfaceImplementation.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterInterface(var InterfaceImplementationBuffer: Record "Interface Implementation" temporary)
    begin
    end;

    procedure LookupInterfaceImplementation(InterfaceCode: Code[20]; var InterfaceImplementation2: Record "Interface Implementation" temporary): Boolean
    begin
        RegisterInterfaces();
        InterfaceImplementation.SetRange("Interface Code", InterfaceCode);
        if Page.RunModal(0, InterfaceImplementation) = Action::LookupOK then begin
            InterfaceImplementation2 := InterfaceImplementation;
            exit(true);
        end;
    end;

    procedure OpenInterfaceImplementationSetupPage(InterfaceCode: Code[20]; ImplementationCode: Code[20])
    begin
        InterfaceImplementation.Get(InterfaceCode, ImplementationCode);
        InterfaceImplementation.TestField("Setup Page ID");
        Page.RunModal(InterfaceImplementation."Setup Page ID");
    end;

    procedure InvokeInterfaceEvent(InterfaceCode: Code[20]; ImplementationCode: Code[20]; EventName: Text; var IntegrationData: Codeunit "App Integration Data"; var Handled: Boolean)
    begin
        Clear(InterfaceCodeunit);
        if not GetInterfaceImplementation(InterfaceCode, ImplementationCode, InterfaceImplementation) then
            Error(NoInterfaceImplementationErr, InterfaceCode);

        InterfaceImplementation.TestField("Codeunit ID");
        Codeunit.Run(InterfaceImplementation."Codeunit ID");
        if not InterfaceCodeunit.IsCodeunit() then
            Error(NoInterfaceCodeunitErr, InterfaceImplementation."Codeunit ID", InterfaceImplementation."Interface Code", InterfaceImplementation."Implementation Code");

        OnInterfaceEvent(EventName, IntegrationData, Handled);
        Clear(InterfaceCodeunit);
    end;

    local procedure GetInterfaceImplementation(InterfaceCode: Code[20]; ImplementationCode: Code[20]; var InterfaceImplementation: Record "Interface Implementation"): Boolean
    begin
        if ImplementationCode <> '' then
            exit(InterfaceImplementation.Get(InterfaceCode, ImplementationCode));

        InterfaceImplementation.SetRange("Interface Code", InterfaceCode);
        if InterfaceImplementation.FindFirst() then
            exit(true);
    end;

    procedure SetInterfaceCodeunit(InterfaceCodeunit2: Variant)
    begin
        InterfaceCodeunit := InterfaceCodeunit2;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInterfaceEvent(EventName: Text; IntegrationData: Codeunit "App Integration Data"; var Handled: Boolean)
    begin
    end;
}