{if E::Topic_IsAllowTopicType($oTopic->getType())}
    {$sTopicTemplateName=$oTopic->getTopicTypeTemplate('show')}
    {include file="topics/$sTopicTemplateName" bTopicList=false}
{/if}
