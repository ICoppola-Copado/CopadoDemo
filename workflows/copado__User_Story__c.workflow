<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Promote</fullName>
        <field>copado__Promote_Change__c</field>
        <literalValue>1</literalValue>
        <name>Flag Promote Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>decide_RT</fullName>
        <field>RecordTypeId</field>
        <lookupValue>copado__Bug</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>decide RT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>update rt</fullName>
        <actions>
            <name>decide_RT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK( Jira_type__c)) &amp;&amp; Jira_type__c = &apos;Bug&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
