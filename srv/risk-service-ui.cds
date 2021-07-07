using RiskService from './risk-service';

annotate RiskService.Risks with {
    title  @title : 'Title';
    prio   @title : 'Prio';
    descr  @title : 'Description';
    miti   @title : 'Mitigation';
    impact @title : 'Impact'
};

annotate RiskService.Mitigations with {
    ID          @(
        UI.Hidden,
        Common : {Text : description, }
    );
    description @title : 'Description';
    owner       @title : 'Owner';
    timeline    @title : 'TimeLine';
    risks       @title : 'Risks'
};

annotate RiskService.Risks with @(UI : {
    HeaderInfo       : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : 'Risk',
        TypeNamePlural : 'Risks',
        Title          : {Value : title},
        Description    : {Value : descr}
    },
    SelectionFields  : [prio],
    LineItem         : [
        {Value : title},
        {Value : miti_ID},
        {
            Value       : prio,
            Criticality : criticality
        },
        {
            Value       : impact,
            Criticality : criticality
        }
    ],
    Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'main',
        Target : '@UI.FieldGroup#Main'
    }],
    FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {Value : miti_ID},
            {
                Value       : prio,
                Criticality : criticality
            },
            {
                Value       : impact,
                Criticality : criticality
            }
        ]
    },
}) {};

annotate RiskService.Risks with {
    miti @(Common : {
        Text            : miti.description,
        TextArrangement : #TextOnly,
        ValueList       : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Mitigations',
            Label          : 'Mitigations',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : miti_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        },
    })
};
