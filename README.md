# Developing a Role Center in Business Central

To create a **Role Center page**, you need to set the PageType property to RoleCenter. 

A Role Center page only contains one area, __RoleCenter__
```
page 50131 "My Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    
    layout
    {
        area(RoleCenter)
        {
           part("Sales Invoice Activities"; "Sales Invoice Activities")
        {
            ApplicationArea = All;
        }
        }
    }
    
  
}
```


A Role Center page is never linked to a source table, but it's created by putting different page parts on the page

- __Headlines__ - Are used to send a greeting to the user and to display unique data insight for a specific role.

- __Activity pages__ - Are used to display information in cues. These pages show financial data and other direct insights for your company or your role. You can use these pages to display key performance indicators (KPIs).

- __My pages__ - Are used to display your favorite or most used records. For example, you can use the My Customers list to display the customer records that you work on frequently. My pages provide a direct access to a specific record.

- __Charts__ - Are used to display data in a graphical way.

## Activity Pages

In the Role Center, an activity page is where you can see cues.
- To create an activity page, you first need to create a source table. 
- These tables are called Cue tables and typically contain many FlowFields, which calculate values that can be displayed in the Role Center.

```
table 50130 "Sales Invoice Cue"
{
    DataClassification =  CustomerContent ;
    Caption = 'Sales Invoice Cue';

    
    fields
    {
       field(1; "Primary Key"; Code[10])
       {
        DataClassification = CustomerContent;
        Caption = 'Primary Key';
       }
       
       field(2; "Sales Invoice - Open"; Integer)
       {
           Caption = 'Sales Invoice Open';
           CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                          Status = const(Open)));
           FieldClass = FlowField;

       }

       field(3; "Sales Invoice - Released"; Integer)
       {
           Caption = 'Sales Invoice Released';
           CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                          Status = const(Released)));
           FieldClass = FlowField;  
       }

       field(4; "Sales This Month"; Decimal)
       {
        DataClassification = CustomerContent;
        Caption = 'Sales This Month';
       }
    }
    
    keys
    {
        key(Pk; "Primary Key")
        {
            Clustered = true;
        }
    }
}
```

- To display the information from a Cue table, you need an activity page.
- You can use the tpage snippet to create a new page and set the PageType property to CardPart. 
- An activity page is a regular CardPart; however, instead of using a group, you should use a cuegroup. 
- All fields that are defined within a cuegroup are displayed as cues on a page.


```
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
}
```

> One important property on the cuegroup level is __CuegroupLayout__, where you can define if your cues are displayed with a wide layout. To use the regular layout, omit the CuegroupLayout property.
