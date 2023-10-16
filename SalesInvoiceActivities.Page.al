page 50130 "Sales Invoice Activities"
{
    PageType = CardPart;
    SourceTable = "Sales Invoice Cue";
    Caption = 'Sales Invoice Activities';
    
    layout
    {
        area(Content)
        {
            cuegroup("Sales Invoice")
            {
                Caption = 'Sales Invoice';
                field("Sales Invoice - Open"; Rec."Sales Invoice - Open")
                {
                    ToolTip = 'Specifies the value of the Sales Invoice - Open field.';
                    ApplicationArea = All;
                }
                 field("Sales Invoice - Released"; Rec."Sales Invoice - Released")
                {
                    ToolTip = 'Specifies the value of the Sales Invoice - Released field.';
                    ApplicationArea = All;
                }
                field("Sales this Month"; Rec."Sales this Month")
                {
                    ToolTip = 'Specifies the value of the Sales this Month field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    
   trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Sales This Month" := Rec.CalcSalesThisMonthAmount();
    end;
}