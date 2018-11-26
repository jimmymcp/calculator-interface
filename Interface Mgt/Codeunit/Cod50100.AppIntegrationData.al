codeunit 50100 "App Integration Data"
{
    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        ValueArray: array[50] of Variant;

    procedure SetIntegationData(Description: Text; Value: Variant);
    var
        Index: Integer;
    begin
        Index := GetIndexNoForDescription(Description, false);
        if Index = 0 then begin
            TempNameValueBuffer.AddNewEntry(Description, '');
            ValueArray[TempNameValueBuffer.ID] := Value;
        end
        else
            ValueArray[Index] := Value;
    end;

    procedure GetIntegrationData(Description: Text; Index: Integer; var Value: Variant): Boolean;
    begin
        if Description > '' then
            Index := GetIndexNoForDescription(Description, false);

        if Index > 0 then begin
            Value := ValueArray[Index];
            exit(true);
        end;

        exit(false);
    end;

    procedure GetIntegrationDataText(Description : Text; Index : Integer) : Text
    var
        Result : Text;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataInt(Description : Text; Index : Integer) : Integer
    var
        Result : Integer;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataDecimal(Description : Text; Index : Integer) : Decimal
    var
        Result : Decimal;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataBoolean(Description : Text; Index : Integer) : Boolean
    var
        Result : Boolean;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataDate(Description : Text; Index : Integer) : Date
    var
        Result : Date;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataDateTime(Description : Text; Index : Integer) : DateTime
    var
        Result : DateTime;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;
    procedure GetIntegrationDataTime(Description : Text; Index : Integer) : Time
    var
        Result : Time;
        VarValue : Variant;
    begin
        if GetIntegrationData(Description,Index,VarValue) then begin
            Result := VarValue;
            exit(Result);
        end;
    end;

    procedure ClearIntegrationData();
    begin
        CLEAR(ValueArray);
        TempNameValueBuffer.DeleteAll();
    end;

    procedure GetIntegrationDataCount(): Integer;
    begin
        exit(TempNameValueBuffer.Count());
    end;

    local procedure GetIndexNoForDescription(Description: Text; ThrowErrorIfNotFound: Boolean): Integer;
    begin
        TempNameValueBuffer.SETRANGE(Name, Description);

        if not TempNameValueBuffer.FindFirst() then
            if ThrowErrorIfNotFound then
                TempNameValueBuffer.FindFirst()
            else begin
                TempNameValueBuffer.SETRANGE(Name);
                exit(0);
            end;

        TempNameValueBuffer.SETRANGE(Name);
        exit(TempNameValueBuffer.ID);
    end;

    procedure GetDescriptionForIndex(Index: Integer): Text;
    begin
        if TempNameValueBuffer.GET(Index) then
            exit(TempNameValueBuffer.Name);

        exit('');
    end;
}

