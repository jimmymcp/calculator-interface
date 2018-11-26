codeunit 50103 "Cos Calculation"
{
    EventSubscriberInstance = Manual;

    local procedure Calculate(var AppIntegrationData : Codeunit "App Integration Data")
    var
        Math : DotNet Math;
        Angle : Decimal;
        Result : Decimal;
    begin
        Angle := AppIntegrationData.GetIntegrationDataDecimal('Angle',0);
        Result := Math.Cos(Angle);
        AppIntegrationData.SetIntegationData('Result',Result);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Mgt.", 'OnInterfaceEvent', '', false, false)]
    local procedure OnInterfaceEvent(EventName: Text; IntegrationData: Codeunit "App Integration Data"; var Handled: Boolean)
    begin
        case EventName of
            'Calculate':
                begin
                    Calculate(IntegrationData);
                    Handled := true;
                end;
        end;
    end;
}